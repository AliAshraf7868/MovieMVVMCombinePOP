//
//  SearchMoviesViewModel.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import Combine
import Foundation

final class SearchMoviesViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [MovieModel] = []
    @Published var recentSearches: [String] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var savedMovieIDs: Set<Int> = []

    private let api: MoviesAPI
    private let recentRepo: RecentSearchRepository
    private let movieRepo: MovieRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(api: MoviesAPI, recentRepo: RecentSearchRepository, movieRepo: MovieRepositoryProtocol) {
        self.api = api
        self.recentRepo = recentRepo
        self.movieRepo = movieRepo

        loadRecentSearches()
        loadSavedMovieIDs()
        
        $searchText
            .debounce(for: .seconds(0.7), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                if !text.isEmpty {
                    self.searchMovies(query: text, saveToRecent: false)
                } else {
                    self.searchResults = []
                }
            }
            .store(in: &cancellables)
    }

    func loadRecentSearches() {
        recentSearches = recentRepo.getRecentSearches()
    }
    
    func deleteRecent(at offsets: IndexSet) {
        for index in offsets {
            let query = recentSearches[index]
            recentRepo.deleteSearch(query: query)
        }
        loadRecentSearches()
    }
    
    func deleteRecent(query: String) {
        recentRepo.deleteSearch(query: query)
        loadRecentSearches()
    }

    func loadSavedMovieIDs() {
        let saved = movieRepo.getSavedMovies()
        savedMovieIDs = Set(saved.map { $0.id })
    }

    func isMovieSaved(_ movie: MovieModel) -> Bool {
        savedMovieIDs.contains(movie.id)
    }

    func toggleSave(movie: MovieModel) {
        movieRepo.toggleSave(movie: movie)
        if savedMovieIDs.contains(movie.id) {
            savedMovieIDs.remove(movie.id)
        } else {
            savedMovieIDs.insert(movie.id)
        }
    }

    func submitSearch() {
        guard !searchText.isEmpty else { return }
        searchMovies(query: searchText, saveToRecent: true)
    }

    func selectRecentSearch(_ query: String) {
        searchText = query
        searchMovies(query: query, saveToRecent: true)
    }

    private func searchMovies(query: String, saveToRecent: Bool) {
        isLoading = true
        error = nil

        api.searchMovies(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(err) = completion {
                    self.error = err.localizedDescription
                }
            }, receiveValue: { response in
                self.searchResults = response.results
                if saveToRecent {
                    self.recentRepo.saveSearch(query: query)
                    self.loadRecentSearches()
                }
            })
            .store(in: &cancellables)
    }
}



