//
//  MovieRepositoryImpl.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation
import Combine

class MovieRepository: MovieRepositoryProtocol {
    
    private let local: MovieLocalDataSource

    init( local: MovieLocalDataSource) {
        self.local = local
    }

    func getSavedMovies() -> [MovieModel] {
        local.fetchSavedMovies()
    }

    func toggleSave(movie: MovieModel) {
        if local.isMovieSaved(id: movie.id) {
            local.delete(movie: movie)
        } else {
            local.save(movie: movie)
        }
    }

    func isMovieSaved(id: Int) -> Bool {
        local.isMovieSaved(id: id)
    }
}

