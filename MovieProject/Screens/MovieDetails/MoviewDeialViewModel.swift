//
//  MoviewDeialViewModel.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 02/07/2025.
//

import Foundation
import Combine

final class MovieDetailViewModel: ObservableObject {
    @Published private(set) var isSaved: Bool
    private let movie: MovieModel
    private let repository: MovieRepositoryProtocol

    init(movie: MovieModel, repository: MovieRepositoryProtocol) {
        self.movie = movie
        self.repository = repository
        self.isSaved = repository.isMovieSaved(id: movie.id)
    }

    var presenter: MovieDetailPresenter {
        MovieDetailPresenter(movie: movie)
    }

    func toggleSave() {
        repository.toggleSave(movie: movie)
        isSaved = repository.isMovieSaved(id: movie.id)
    }
}
