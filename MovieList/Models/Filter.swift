//
//  Filter.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

struct FilterState<T> {
    let value: T
    var isSelected: Bool
}

enum Filter: Equatable {
    case genres([Genre])
    case languages([Language])

    private var parameterName: String {
        switch self {
        case .genres:
            return "with_genres"
        case .languages:
            return "language"
        }
    }

    var query: URLQueryItem {
        switch self {
        case let .genres(genres):
            let joined = genres.map(\.name).joined(separator: "%2C")
            return URLQueryItem(name: parameterName, value: joined)
        case let .languages(languages):
            let joined = languages.map(\.iso_639_1).joined(separator: "%2C")
            return URLQueryItem(name: parameterName, value: joined)
        }
    }

    static func == (lhs: Filter, rhs: Filter) -> Bool {
        switch lhs {
        case .genres(let genres):
            guard case .genres(let rhsGenres) = rhs else {
                return false
            }

            return genres == rhsGenres
        case .languages(let languages):
            guard case .languages(let rhsLanguages) = rhs else {
                return false
            }

            return languages == rhsLanguages
        }
    }

}
