//
//  MoviePosterView.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/14/23.
//

import SwiftUI

struct MoviePosterView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if phase.error != nil {
                PlaceHolder()
            } else {
                ProgressView()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    private func PlaceHolder() -> some View {
        Image(systemName: "popcorn.circle")
            .background(Color.red.opacity(0.8))
    }
}


struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterView(url: nil)
    }
}
