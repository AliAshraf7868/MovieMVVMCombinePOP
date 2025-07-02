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


final class APIClient: APIRequestable {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, decodingType: T.Type) -> AnyPublisher<T, APIError> {
        var components = URLComponents(string: API.baseURL + endpoint.path)!
        
        components.queryItems = endpoint.fullQueryItems
        guard let url = components.url else {
            return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
#if DEBUG
        print("➡️ \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        if let body = request.httpBody {
            print("BODY: \(String(data: body, encoding: .utf8) ?? "")")
        }
#endif
        
        return session.dataTaskPublisher(for: request)
            .mapError { APIError.network(message: $0.localizedDescription) }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    return Fail(error: APIError.status(message: "Invalid response")).eraseToAnyPublisher()
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


