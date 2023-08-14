//
//  MovieListError.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

struct MovieListError: Codable, Error {
    let statusCode: Int?
    let statusMessage: String?
    let success: Bool
    let errors: [String]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success, errors
    }

    static let decodingError = MovieListError(
        statusMessage: "Unable to decode data",
        success: false
    )

    init(
        statusCode: Int? = nil,
        statusMessage: String? = nil,
        success: Bool,
        errors: [String]? = nil
    ) {
        self.statusCode = statusCode
        self.statusMessage = statusMessage
        self.success = success
        self.errors = errors
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMessage = try container.decodeIfPresent(String.self, forKey: .statusMessage)
        success = try container.decode(Bool.self, forKey: .success)
        errors = try container.decodeIfPresent([String].self, forKey: .errors)
    }
}
