//
//  Genre.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

struct GenresContainer: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
}
