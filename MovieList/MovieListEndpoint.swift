//
//  MovieListEndpoint.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

enum MovieListEndpoint {
    case languages
    case genres
    case movies

    private var baseURL: String {
        "https://api.themoviedb.org/3"
    }

    private var relativePath: String {
        switch self {
        case .languages:
            return "/configuration/languages"
        case .genres:
            return "/genre/movie/list"
        case .movies:
            return "/discover/movie"
        }
    }

    var url: URL {
        URL(string: baseURL+relativePath)!
    }
}
