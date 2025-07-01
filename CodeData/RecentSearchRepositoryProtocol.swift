//
//  RecentSearchRepositoryProtocol.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import Foundation

protocol RecentSearchRepositoryProtocol {
    func saveSearch(query: String)
    func getRecentSearches(limit: Int) -> [String]
    func deleteSearch(query: String)
}
