//
//  Language.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

struct Language: Codable, Identifiable, Equatable {
    let englishName: String
    let iso_639_1: String
    let name: String

    var id: String {
        iso_639_1
    }

    enum CodingKeys: String, CodingKey {
        case iso_639_1, name
        case englishName = "english_name"
    }
}
