//
//  MovieCardView.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCardView: View {
    let movie: MovieModel
    let isSaved: Bool
    let onSaveTapped: () -> Void

    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    Image("DefaultMovieImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight * 0.7)
                        .clipped()
                        .cornerRadius(10)
                    
                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.backdropPath ?? "")"))
                        .resizable()
                    //                    .placeholder {
                    //                        Image("DefaultMovieImage")
                    //                            .resizable()
                    //                            .scaledToFill()
                    //                    }
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight * 0.7)
                        .clipped()
                        .cornerRadius(10)
                    
                    Button(action: onSaveTapped) {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.black.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(6)
                    }
                }
                
                Text(movie.title ?? "No Title")
                    .font(.caption)
                    .lineLimit(1)
                
                Text("⭐️ \(movie.voteAverage.map { String(format: "%.1f", $0) } ?? "-")")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(width: cardWidth, height: cardHeight)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 4)
        }
    }
}


#Preview {
    MovieCardView(
        movie: MovieModel(
            id: 1,
            title: "Sample Movie",
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
        onSaveTapped: {},
        cardWidth: UIScreen.main.bounds.width/2,
        cardHeight: UIScreen.main.bounds.height/3
    )
}
