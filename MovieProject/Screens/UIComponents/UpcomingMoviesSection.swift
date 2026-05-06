//
//  UpcomingMoviesSection.swift
//  MovieProject
//
//  Created by Ali Ashraf on 07/07/2025.
//

import SwiftUI

struct UpcomingMoviesSection: View {
    @ObservedObject var viewModel: MoviesViewModel
    
    var body: some View {
//        VStack {
            if viewModel.isLoadingUpcoming {
                ProgressView("Loading upcoming movies...")
                    .padding(.leading)
            } else if let error = viewModel.upcomingError {
                VStack {
                    Text("Error loading upcoming movies: \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        viewModel.fetchUpcomingMovies()
                    }
                    .padding()
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                            NavigationLink(
                                destination: MovieDetailView(
                                    viewModel: MovieDetailViewModel(movie: movie, repository: viewModel.repository)
                                )
                            ) {
                                UpcomingMoviePosterView(
                                    movie: movie,
                                    isSaved: viewModel.isMovieSaved(movie.id),
                                    onSaveTapped: {
                                        viewModel.toggleSave(movie: movie)
                                    }
                                )
                                .frame(width: 220, height: 140)
                            }
                            .onAppear {
                                viewModel.loadMoreUpcomingIfNeeded(current: movie)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 160)
            }
//        }
        
    }
}

#Preview {
//    UpcomingMoviesSection()
}
