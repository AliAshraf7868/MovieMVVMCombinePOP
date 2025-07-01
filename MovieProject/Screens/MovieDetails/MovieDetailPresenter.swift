//
//  MovieDetailPresenter.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import Foundation

struct MovieDetailPresenter: MovieDetailPresentable {
    private let movie: MovieModel

    init(movie: MovieModel) {
        self.movie = movie
    }

    var title: String {
        movie.title ?? "No Title"
    }

    var overview: String {
        movie.overview ?? "No description available."
    }

    var posterURL: URL? {
        if let path = movie.posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500/\(path)")
        }
        return nil
    }

    var releaseDate: String {
        "Release: \(movie.releaseDate ?? "N/A")"
    }

    var voteAverage: String {
        "Rating: \(movie.voteAverage.map { "\($0)" } ?? "N/A")"
    }
    
    var backDropURL: URL? {
        if let path = movie.backdropPath {
            return URL(string: "https://image.tmdb.org/t/p/w500/\(path)")
        }
        return nil
    }
}
