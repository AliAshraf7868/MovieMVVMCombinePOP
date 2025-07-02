//
//  MovieRepository.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func getSavedMovies() -> [MovieModel]
    func toggleSave(movie: MovieModel)
    func isMovieSaved(id: Int) -> Bool
}
