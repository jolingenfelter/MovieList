//
//  MovieListRow.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import SwiftUI

struct MovieListRow: View {
    let movie: Movie

    var body: some View {
        if let title = movie.title {
            Text(title)
        }
    }
}
