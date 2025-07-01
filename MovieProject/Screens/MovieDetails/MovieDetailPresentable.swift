//
//  MovieDetailPresentable.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import Foundation

protocol MovieDetailPresentable {
    var title: String { get }
    var overview: String { get }
    var posterURL: URL? { get }
    var backDropURL: URL? { get }
    var releaseDate: String { get }
    var voteAverage: String { get }
}
