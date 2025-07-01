//
//  APIURL.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation


enum API {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
}




struct SearchMoviesEndpoint: Endpoint {
    let query: String
    var path: String { "/search/movie" }
    var method: HTTPMethod { .GET }
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "api_key", value: APIKeys.tmdb),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "language", value: "en-US")
        ]
    }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
}

struct PopularMoviesEndpoint: Endpoint {
    let page: Int

    var path: String { "/movie/popular" }
    var method: HTTPMethod { .GET }
    var queryItems: [URLQueryItem]
    {
        var items = [URLQueryItem(name: "language", value: "en-US")]
        if page > 0 {
            items.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        return items
    }

    var headers: [String : String]? { nil }
    var body: Data? { nil }
}



//enum MovieEndpoint {
//    case popular(page: Int)
//    case search(query: String, page: Int)
//
//    var path: String {
//        switch self {
//        case .popular: return "/movie/popular"
//        case .search: return "/search/movie"
//        }
//    }
//
//    var queryItems: [URLQueryItem] {
//        switch self {
//        case .popular(let page):
//            return [
//                URLQueryItem(name: "language", value: "en-US"),
//                URLQueryItem(name: "page", value: "\(page)")
//            ]
//        case .search(let query, let page):
//            return [
//                URLQueryItem(name: "language", value: "en-US"),
//                URLQueryItem(name: "query", value: query),
//                URLQueryItem(name: "page", value: "\(page)"),
//                URLQueryItem(name: "include_adult", value: "false")
//            ]
//        }
//    }
//}
