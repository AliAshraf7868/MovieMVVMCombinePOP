//
//  SavedMoviesViewModel.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import Foundation
import Combine

final class SavedMoviesViewModel: ObservableObject {
    
    @Published var savedMovies: [MovieModel] = []

    private let movieRepo: MovieRepositoryProtocol

    init(movieRepo: MovieRepositoryProtocol) {
        self.movieRepo = movieRepo
        loadSavedMovies()
    }

    func loadSavedMovies() {
        savedMovies = movieRepo.getSavedMovies()
    }

    func toggleSave(movie: MovieModel) {
        movieRepo.toggleSave(movie: movie)
        loadSavedMovies() // reload after toggle
    }

    func isMovieSaved(_ movie: MovieModel) -> Bool {
        movieRepo.isMovieSaved(id: movie.id)
    }
}

