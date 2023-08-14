//
//  MovieDetailView.swift
//  MovieList
//
//  Created by Jo Lingenfelter on 8/14/23.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    @ScaledMetric
    private var spacing: CGFloat = 25

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: spacing) {
                    MoviePosterView(url: movie.posterURL)
                        .frame(maxWidth: 0.6 * geometry.size.width)
                    
                    Text(movie.overview)
                        .padding(.horizontal)
                }
                .frame(minHeight: geometry.size.height, alignment: .top)
                .scenePadding()
            }
            .navigationTitle(movie.title)
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    let movie = Movie(from: <#T##Decoder#>)
//    static var previews: some View {
//        MovieDetailView(movie: <#Movie#>)
//    }
//}
