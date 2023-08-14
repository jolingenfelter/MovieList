//
//  Movie.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

struct Movie: Codable, Identifiable {
    let title: String?
    let releaseDate: String?
    let overview: String?
    let genre: Genre?
    let id: Int
    let moviePosterPath: String?
}

extension Movie {
    var moviePosterURL: URL? {
        guard let moviePosterPath else {
            return nil
        }

        return URL(string: "https://image.tmdb.org/t/p/w500\(moviePosterPath)")!
    }
}
