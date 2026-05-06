//
//  PopularMoviesSection.swift
//  MovieProject
//
//  Created by Ali Ashraf on 07/07/2025.
//

import SwiftUI

struct PopularMoviesSection: View {
    @ObservedObject var viewModel: MoviesViewModel
    let columns: [GridItem]

    var body: some View {
//        VStack {
            if viewModel.isLoadingPopular {
                ProgressView("Loading popular movies...")
                    .padding(.top, 20)
            } else if let error = viewModel.popularError {
                VStack {
                    Text("Error loading popular movies: \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        viewModel.fetchPopularMovies()
                    }
                    .padding()
                }
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.popularMovies, id: \.id) { movie in
                        
                        NavigationLink(
                            destination: MovieDetailView(
                                viewModel: MovieDetailViewModel(movie: movie, repository: viewModel.repository)
                            )
                        ) {
                            MoviePosterView(
                                movie: movie,
                                isSaved: viewModel.isMovieSaved(movie.id),
                                onSaveTapped: {
                                    viewModel.toggleSave(movie: movie)
                                }
                            )
                        }
                        .onAppear {
                            viewModel.loadMorePopularIfNeeded(current: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
//    }
}

#Preview {
//    PopularMoviesSection(viewModel: <#MoviesViewModel#>, columns: <#[GridItem]#>)
}
