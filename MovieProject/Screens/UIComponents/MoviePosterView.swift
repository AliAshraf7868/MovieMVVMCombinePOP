//
//  MoviePosterView.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviePosterView: View {
    let movie: MovieModel
    let isSaved: Bool
    let onSaveTapped: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottomLeading) {
                
                Image("Default")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(10)
                
                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"))
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 4)
                if let title = movie.title {
                    Text(title)
                        .font(.system(size: 18))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(1)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(5)
                        .padding([.leading, .bottom], 10)
                }
                
            }
            Button(action: onSaveTapped) {
                Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.black.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(8)
        }
    }
}



#Preview {
    MoviePosterView(
        movie: MovieModel(
            id: 1,
            title: "This is the name of sample movie which is look like this Sample Movie",
            originalTitle: "Sample Movie Original",
            overview: "This is a sample movie overview.",
            releaseDate: "2025-01-01",
            posterPath: "/skSoZMossoIYvzOf2UnaWqLscJl.jpg",
            backdropPath: nil,
            genreIDs: [12, 28],
            popularity: 100.0,
            voteAverage: 7.5,
            voteCount: 500,
            adult: false,
            originalLanguage: "en",
            video: false
        ),
        isSaved: true,
        onSaveTapped: {}
    )
}
