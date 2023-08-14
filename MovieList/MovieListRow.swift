//
//  MovieListRow.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import SwiftUI

struct MovieListRow: View {
    let movie: Movie

    @ScaledMetric(relativeTo: .caption)
    private var captionHeight: CGFloat = 100

    var body: some View {
        HStack(alignment: .top) {
            MoviePosterView(url: movie.posterURL)
                .frame(maxWidth: 80)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)

                Text(movie.overview)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .frame(maxHeight: captionHeight)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}
