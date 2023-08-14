//
//  MovieListRow.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/13/23.
//

import SwiftUI

struct MovieListRow: View {
    let movie: Movie

    @ScaledMetric(relativeTo: .headline)
    private var height: CGFloat = 160

    @ScaledMetric(relativeTo: .caption)
    private var captionHeight: CGFloat = 60

    var body: some View {
        HStack {
            AsyncImage(url: movie.posterURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image(systemName: "popcorn.circle")
                        .background(Color.red.opacity(0.8))
                } else {
                    ProgressView()
                }
            }
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
            .padding()
        }
        .frame(height: height)
    }
}
