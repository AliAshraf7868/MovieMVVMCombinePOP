//
//  APIErrorResponse.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation

struct APIErrorResponse: Codable, Error {
    let statusCode: Int
    let statusMessage: String
    let success: Bool
}
