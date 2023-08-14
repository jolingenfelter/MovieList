//
//  MovieClientResultType.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

enum MovieListResultType<T: Codable> {
    case success(T)
    case error(MovieListError)

    init(data: Data) throws {
        let decoder = JSONDecoder()

        if let error = try? decoder.decode(MovieListError.self, from: data) {
            self = .error(error)
        } else if let result = try? decoder.decode(T.self, from: data) {
            self = .success(result)
        } else {
            self = .error(.decodingError)
        }
    }
}


