//
//  APIError.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation


enum APIError: Error {
    case request(message: String)
    case network(message: String)
    case status(message: String)
    case parsing(message: String)
    case other(message: String)

    static func map(_ error: Error) -> APIError {
        return (error as? APIError) ?? .other(message: error.localizedDescription)
    }
}
