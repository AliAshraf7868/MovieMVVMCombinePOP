//
//  MoviesViewModel.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation
import Combine

import Combine
import Foundation

final class MoviesViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var popularMovies: [MovieModel] = []
    @Published var upcomingMovies: [MovieModel] = []

    @Published var isLoadingPopular: Bool = true
    @Published var isLoadingUpcoming: Bool = true

    @Published var isLoadingMorePopular: Bool = false
    @Published var isLoadingMoreUpcoming: Bool = false
    
    @Published var isFirstLoad: Bool = true

    @Published var popularError: String?
    @Published var upcomingError: String?

    @Published private(set) var savedMovieIDs: Set<Int> = []

    // MARK: - Private state
    private var cancellables = Set<AnyCancellable>()
    private let api: MovieAPIProtocol
    let repository: MovieRepositoryProtocol
    private var popularPage = 1
    private var upcomingPage = 1
    private var canLoadMorePopular = true
    private var canLoadMoreUpcoming = true

    // Keep track of last triggers to prevent repeat calls
    private var lastPopularPageTriggerIndex: Int = -1
    private var lastUpcomingPageTriggerIndex: Int = -1

    // MARK: - Init
    init(api: MovieAPIProtocol, repository: MovieRepositoryProtocol) {
        self.api = api
        self.repository = repository
        loadSavedMovieIDs()
    }

    // MARK: - Toggle Save
    func toggleSave(movie: MovieModel) {
        repository.toggleSave(movie: movie)
        if savedMovieIDs.contains(movie.id) {
            savedMovieIDs.remove(movie.id)
        } else {
            savedMovieIDs.insert(movie.id)
        }
    }

    func isMovieSaved(_ id: Int) -> Bool {
        savedMovieIDs.contains(id)
    }

    private func loadSavedMovieIDs() {
        let saved = repository.getSavedMovies()
        savedMovieIDs = Set(saved.map { $0.id })
    }

    // MARK: - Fetch Popular
    func fetchPopularMovies() {
        if popularPage == 1 {
            popularError = nil
        } else {
            isLoadingMorePopular = true
        }
        popularPage += 1
        api.fetchPopularMovies(page: popularPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.isLoadingPopular = false
                self.isLoadingMorePopular = false
                if case let .failure(error) = completion {
                    self.popularError = error.localizedDescription
                    if self.popularPage > 1 { self.popularPage -= 1 }
                }
            }, receiveValue: { response in
                self.isLoadingPopular = false
                self.isLoadingMorePopular = false
                if self.popularPage == 1 {
                    self.popularMovies = response.results
                } else {
                    self.popularMovies.append(contentsOf: response.results)
                }
                self.canLoadMorePopular = self.popularPage < (response.totalPages ?? 0) &&
                                          self.popularMovies.count < (response.totalResults ?? 0)
            })
            .store(in: &cancellables)
    }

    func loadMorePopularIfNeeded(current movie: MovieModel) {
        guard canLoadMorePopular, !isLoadingMorePopular,
              let index = popularMovies.firstIndex(where: { $0.id == movie.id }),
              index >= popularMovies.count - 6,
              index != lastPopularPageTriggerIndex else { return }

        lastPopularPageTriggerIndex = index
        
        fetchPopularMovies()
    }

    // MARK: - Fetch Upcoming
    func fetchUpcomingMovies() {
        if upcomingPage == 1 {
            upcomingError = nil
        } else {
            isLoadingMoreUpcoming = true
        }
        upcomingPage += 1
        api.fetchUpcomingMovies(page: upcomingPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.isLoadingUpcoming = false
                self.isLoadingMoreUpcoming = false
                if case let .failure(error) = completion {
                    self.upcomingError = error.localizedDescription
                    if self.upcomingPage > 1 { self.upcomingPage -= 1 }
                }
            }, receiveValue: { response in
                self.isLoadingUpcoming = false
                self.isLoadingMoreUpcoming = false
                if self.upcomingPage == 1 {
                    self.upcomingMovies = response.results
                } else {
                    self.upcomingMovies.append(contentsOf: response.results)
                }
                self.canLoadMoreUpcoming = self.upcomingPage < (response.totalPages ?? 0) &&
                                           self.upcomingMovies.count < (response.totalResults ?? 0)
            })
            .store(in: &cancellables)
    }

    func loadMoreUpcomingIfNeeded(current movie: MovieModel) {
        guard canLoadMoreUpcoming, !isLoadingMoreUpcoming,
              let index = upcomingMovies.firstIndex(where: { $0.id == movie.id }),
              index >= upcomingMovies.count - 6,
              index != lastUpcomingPageTriggerIndex else { return }

        lastUpcomingPageTriggerIndex = index
        
        fetchUpcomingMovies()
    }
}




//    func loadMoreUpcomingIfNeeded(current movie: MovieModel) {
//        guard !isLoadingMoreUpcoming && canLoadMoreUpcoming else { return }
//        let thresholdIndex = upcomingMovies.index(upcomingMovies.endIndex, offsetBy: -5)
//        if upcomingMovies.firstIndex(where: { $0.id == movie.id }) == thresholdIndex {
//            upcomingPage += 1
//            fetchUpcomingMovies()
//        }
//    }

//    private func loadMoreMovies() {
//        api.fetchPopularMovies(page: currentPage)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//
//                if case let .failure(apiError) = completion {
//                    self.error = apiError.localizedDescription
//                }
//            }, receiveValue: { response in
//                self.movies.append(contentsOf: response.results)
//                self.canLoadMorePages = self.currentPage < response.totalPages ?? 0 && self.movies.count < response.totalResults ?? 0
//            })
//            .store(in: &cancellables)
//    }
