
//
//  AnyEncodable.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 02/07/2025.
//

import Foundation

struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void

    init<T: Encodable>(_ wrapped: T) {
        self._encode = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
