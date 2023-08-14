//
//  Filter.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

enum Filter {
    case genres([Genre])
    case language(Language)

    private var parameterName: String {
        switch self {
        case .genres:
            return "with_genres"
        case .language:
            return "language"
        }
    }

    var query: URLQueryItem {
        switch self {
        case let .genres(genres):
            let joined = genres.map(\.name).joined(separator: "%2C")
            return URLQueryItem(name: parameterName, value: joined)
        case let .language(language):
            return URLQueryItem(name: parameterName, value: language.iso_639_1)
        }
    }
}
