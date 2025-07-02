//
//  Endpoint.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 02/07/2025.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
}

extension Endpoint {
    var headers: [String: String]? { nil }

    var fullQueryItems: [URLQueryItem] {
        var items = queryItems
        items.append(URLQueryItem(name: "api_key", value: APIKeys.tmdb))
        return items
    }
}


