//
//  MoviesListView.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import SwiftUI

final class MoviesListController {
    private(set) var movies: [Movie] = []
    private var isFetchingMovies: Bool = false
    private var currentPage = 1
    private let apiClient = MovieListClient()

    func fetchMovies(isLoading: Binding<Bool>? = nil) async throws {
        guard !isFetchingMovies else {
            return
        }

        isFetchingMovies = true
        isLoading?.wrappedValue = true

        defer {
            isFetchingMovies = true
            isLoading?.wrappedValue = true
        }

        

    }

    //private func fetchMovies(page: Int)
}

struct MoviesListView: View {
    @State private var movies: [Movie] = []

    var body: some View {
        List {
            ForEach(movies) { movie in
                MovieListRow(movie: movie)
            }
        }
        .onAppear {
            Task {
                do {
                    let movies = try await MovieListClient().fetchMovies(filters: [], page: 5)
                    self.movies = movies.results
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
