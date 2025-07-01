//
//  MovieModel.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation

struct MovieModel: Codable, Identifiable {
    let id: Int
    let title: String?
    let originalTitle: String?
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
    let genreIDs: [Int]?
    let popularity: Double?
    let voteAverage: Double?
    let voteCount: Int?
    let adult: Bool?
    let originalLanguage: String?
    let video: Bool?
}



struct MovieResponse: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


