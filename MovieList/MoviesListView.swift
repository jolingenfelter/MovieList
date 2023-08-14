//
//  MoviesListView.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import SwiftUI

struct MoviesListView: View {
    @State private var controller = MoviesListController()

    var body: some View {
        NavigationStack {
            List {
                ForEach(controller.movies) { movie in
                    MovieListRow(movie: movie)
                        .onAppear {
                            Task {
                                await controller.fetchMoviesIfNeeded(after: movie)
                            }
                        }
                }
            }
            .navigationTitle("Movies List")
            .navigationBarTitleDisplayMode(.large)
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
