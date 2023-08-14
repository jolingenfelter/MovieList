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
    private var height: CGFloat = 80

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

            Text(movie.title)
                .font(.headline)
                .padding()
        }
        .frame(height: height)
    }
}
