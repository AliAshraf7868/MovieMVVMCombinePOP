//
//  EndPoints.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 02/07/2025.
//

import Foundation

struct SearchMoviesEndpoint: Endpoint {
    
    let query: String
    var path: String = API.searchUrl
    var method: HTTPMethod { .GET }
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "language", value: "en-US")
        ]
    }
    var body: (any Encodable)?
}

struct PopularMoviesEndpoint: Endpoint {
    
    let page: Int
    var path: String = API.popularUrl
    var method: HTTPMethod { .GET }
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem(name: "language", value: "en-US")]
        if page > 0 {
            items.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        return items
    }
    var body: (any Encodable)?
}
