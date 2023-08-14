//
//  MoviesListController.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/14/23.
//

import SwiftUI

struct MoviesListState {
    var movies: [Movie] = []
    var pageIndex: Int = 1
    var isLoading: Bool = false
    var filters: [Filter] = []
}

final class MoviesListController {
    private let apiClient = MovieListClient()

    @Binding var state: MoviesListState

    init(state: Binding<MoviesListState>) {
        _state = state
    }

    func fetchMoviesIfNeeded(after movie: Movie? = nil) async throws {
        if movie == state.movies.last {
            try await fetchMovies()
        } else if state.movies.isEmpty {
            try await fetchMovies()
        }
    }

    private func fetchMovies() async throws {
        guard !state.isLoading  else {
            return
        }

        state.isLoading = true

        defer {
            state.isLoading = false
        }


        let paginatedResult = try await apiClient.fetchMovies(filters: state.filters, page: state.pageIndex)
        state.movies.append(contentsOf: paginatedResult.results)
        state.pageIndex += 1
    }
}
