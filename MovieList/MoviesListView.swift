//
//  MoviesListView.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import SwiftUI

struct MoviesListView: View {
    @State private var state = MoviesListState()

    private var controller: MoviesListController {
        MoviesListController(state: $state)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(state.movies) { movie in
                    MovieListRow(movie: movie)
                        .onAppear {
                            Task {
                                do {
                                    try await controller.fetchMoviesIfNeeded(after: movie)
                                } catch {
                                    print(error)
                                }
                            }
                        }
                }
            }
            .navigationTitle("Movies List")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            Task {
                do {
                    try await controller.fetchMoviesIfNeeded()
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
