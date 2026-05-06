//
//  SaveListCard.swift
//  MovieProject
//
//  Created by Ali Ashraf on 07/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct SaveListCard: View {
    let movie: MovieModel
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: "\(API.imageBaseURL)\(movie.posterPath ?? "")"))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 100, height: 175)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(movie.title ?? "")
                    .font(.headline)
                    .padding(.vertical)
                MPImageText(imageName: "star", text: String(movie.voteAverage ?? 5))
                Text("Ali Ashraf")
                    .font(.caption)
                Text("Ali Ashraf")//tray.full
                    .font(.caption)
                Text("Ali Ashraf")
                    .font(.caption)
            }
        }
        .frame(height: 170)
    }
}

#Preview {
    SaveListCard(
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
        )
    )
}
