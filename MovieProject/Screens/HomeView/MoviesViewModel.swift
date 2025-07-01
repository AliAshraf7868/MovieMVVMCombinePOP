//
//  MoviesViewModel.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation
import Combine

final class MoviesViewModel: ObservableObject {
    
    @Published var movies: [MovieModel] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var error: String?
    @Published var isSaved: Bool = false
    
    private let api: MoviesAPI
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var canLoadMorePages = true
    private let repository: MovieRepositoryProtocol
    
    init(api: MoviesAPI, repository: MovieRepositoryProtocol) {
        self.api = api
        self.repository = repository
    }
    
    func toggleSave(movie: MovieModel) {
        repository.toggleSave(movie: movie)
        objectWillChange.send() // force update of views
    }
    
    func isMovieSaved(_ id: Int) -> Bool {
        repository.isMovieSaved(id: id)
    }
    
    func fetchPopularMovies() {
        isLoading = true
        error = nil
        currentPage = 1
        canLoadMorePages = true
        
        api.fetchMovies(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(apiError) = completion {
                    self.error = apiError.localizedDescription
                }
            }, receiveValue: { response in
                self.movies = response.results
                self.canLoadMorePages = self.currentPage < response.totalPages ?? 10
            })
            .store(in: &cancellables)
    }
    
    func loadMoreMoviesIfNeeded(currentMovie movie: MovieModel) {
        guard !isLoadingMore && canLoadMorePages else { return }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == movie.id }) == thresholdIndex {
            loadMoreMovies()
        }
    }
    
    private func loadMoreMovies() {
        isLoadingMore = true
        currentPage += 1
        
        api.fetchMovies(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoadingMore = false
                if case let .failure(apiError) = completion {
                    self.error = apiError.localizedDescription
                }
            }, receiveValue: { response in
                self.movies.append(contentsOf: response.results)
                self.canLoadMorePages = self.currentPage < response.totalPages ?? 10
            })
            .store(in: &cancellables)
    }
    
}


