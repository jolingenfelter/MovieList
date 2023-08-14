//
//  PaginatedResult.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import Foundation

struct PaginatedResult<T:Codable>: Codable {
    let page: Int
    let results: [T]
}
