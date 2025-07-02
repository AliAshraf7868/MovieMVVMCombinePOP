//
//  MoviesAPI.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation
import Combine

protocol MovieAPIProtocol {
    func fetchMovies(page: Int) -> AnyPublisher<MovieResponse, APIError>
    func searchMovies(query: String) -> AnyPublisher<MovieResponse, APIError>
}

final class MoviesAPI: MovieAPIProtocol {
    private let client: APIRequestable

    init(client: APIRequestable) {
        self.client = client
    }

    func fetchMovies(page: Int) -> AnyPublisher<MovieResponse, APIError> {
        client.request(PopularMoviesEndpoint(page: page), decodingType: MovieResponse.self)
    }

    func searchMovies(query: String) -> AnyPublisher<MovieResponse, APIError> {
        client.request(SearchMoviesEndpoint(query: query), decodingType: MovieResponse.self)
    }
}
