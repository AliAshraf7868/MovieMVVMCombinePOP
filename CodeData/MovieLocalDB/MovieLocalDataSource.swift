//
//  MovieLocalDataSource.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation

protocol MovieLocalDataSource {
    func save(movie: MovieModel)
    func delete(movie: MovieModel)
    func fetchSavedMovies() -> [MovieModel]
    func isMovieSaved(id: Int) -> Bool
}
