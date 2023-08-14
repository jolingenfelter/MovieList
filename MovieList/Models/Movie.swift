//
//  Movie.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

struct Movie: Codable, Identifiable {
    let title: String
    let releaseDate: String?
    let overview: String
    let genreIds: [Int]
    let id: Int
    let posterPath: String?
    let originalLanguage: String

    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case overview
        case genreIds = "genre_ids"
        case id
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.id = try container.decode(Int.self, forKey: .id)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
    }
}

extension Movie {
    var posterURL: URL? {
        guard let posterPath else {
            return nil
        }

        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
    }
}
