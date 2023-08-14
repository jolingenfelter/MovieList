//
//  MoviesListView.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import SwiftUI

// Filters
/*
 - Sheet
 - Picker
 - Struct with available filters and selected filters

 */

struct MoviesListView: View {
    @State private var controller = MoviesListController()

    var body: some View {
        NavigationStack {
            List {
                ForEach(controller.movies) { movie in
                    NavigationLink(value: movie) {
                        MovieListRow(movie: movie)
                    }.onAppear {
                        Task {
                            await controller.fetchMoviesIfNeeded(after: movie)
                        }
                    }
                }
            }
            .navigationTitle("Movies List")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
        .onAppear {
            Task {
                await controller.fetchMoviesIfNeeded()
            }
        }
        .alert($controller.error)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
