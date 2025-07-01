//
//  MovieDetailView.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView<Presenter: MovieDetailPresentable>: View {
    let presenter: Presenter
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = presenter.posterURL {
                    WebImage(url: url)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .shadow(radius: 8)
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height / 1.8)
                }

                Text(presenter.title)
                    .font(.title)
                    .bold()

                Text(presenter.releaseDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(presenter.voteAverage)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(presenter.overview)
                    .font(.body)
                    .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle("Movie Details")
    }
}
#Preview {
    let movie = MovieModel(
        id: 1,
        title: "Inception",
        originalTitle: nil,
        overview: "A thief who steals corporate secrets through the use of dream-sharing technology.",
        releaseDate: "2010-07-16",
        posterPath: "/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg",
        backdropPath: "/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg",
        genreIDs: nil, popularity: nil, voteAverage: 8.3, voteCount: nil, adult: nil, originalLanguage: nil, video: true
    )
    let presenter = MovieDetailPresenter(movie: movie)
    MovieDetailView(presenter: presenter)
}
