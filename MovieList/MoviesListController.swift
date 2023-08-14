//
//  MoviesListController.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/14/23.
//

import SwiftUI

struct MoviesListController {
    private let apiClient = MovieListClient()

    private(set) var movies: [Movie] = []
    private(set) var pageIndex: Int = 1
    private(set) var isLoading: Bool = false

    var filters: [Filter] = []
    var error: AlertModel? = nil

    mutating
    func fetchMoviesIfNeeded(after movie: Movie? = nil) async {
        if movie == movies.last || movies.isEmpty  {
            await fetchMovies()
        }
    }

    mutating
    private func fetchMovies() async {
        guard !isLoading  else {
            return
        }

        isLoading = true

        defer {
            isLoading = false
        }

        do {
            let paginatedResult = try await apiClient.fetchMovies(filters: filters, page: pageIndex)
            movies.append(contentsOf: paginatedResult.results)
            pageIndex += 1
        } catch {
            self.error = AlertModel(
                title: "Error",
                message: error.localizedDescription,
                actions: [.ok]
            )
        }
    }
}
