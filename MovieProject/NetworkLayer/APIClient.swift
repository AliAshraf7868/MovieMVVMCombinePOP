//
//  MoviesAPI.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation
import Combine

protocol APIRequestable {
    func request<T: Decodable>(_ endpoint: Endpoint, decodingType: T.Type) -> AnyPublisher<T, APIError>
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}


final class APIClient: APIRequestable {
    private let session: URLSession
    

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint, decodingType: T.Type) -> AnyPublisher<T, APIError> {
        var components = URLComponents(string: API.baseURL + endpoint.path)!
        components.queryItems = endpoint.queryItems + [URLQueryItem(name: "api_key", value: APIKeys.tmdb)]

        guard let url = components.url else {
            return Fail(error: APIError.request(message: "Invalid URL"))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.allHTTPHeaderFields = endpoint.headers

        return session.dataTaskPublisher(for: request)
            .mapError { APIError.network(message: $0.localizedDescription) }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    return Fail(error: APIError.status(message: "Invalid response"))
                        .eraseToAnyPublisher()
                }

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                return Just(data)
                    .decode(type: T.self, decoder: decoder)
                    .mapError { APIError.parsing(message: $0.localizedDescription) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}


