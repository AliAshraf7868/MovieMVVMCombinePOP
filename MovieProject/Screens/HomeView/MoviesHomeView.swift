//
//  MoviesHomeView.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviesHomeView: View {
    @StateObject private var viewModel: MoviesViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    init(api: MoviesAPI, repository: MovieRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: MoviesViewModel(api: api, repository: repository))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading movies...")
                        .padding(.top, 100)
                } else if let error = viewModel.error {
                    VStack {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            viewModel.fetchPopularMovies()
                        }
                        .padding()
                    }
                    .padding(.top, 100)
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink(destination:
                                            MovieDetailView(
                                                viewModel: MovieDetailViewModel(
                                                    movie: movie,
                                                    repository: viewModel.repository
                                                )
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
                                viewModel.loadMoreMoviesIfNeeded(currentMovie: movie)
                            }
                        }
                        .padding()
                    }
                    
                    .navigationTitle("Popular Movies")
                    .navigationBarTitleDisplayMode(.automatic)
                    
                }
            }
        }
        .onAppear {
            viewModel.fetchPopularMovies()
        }
    }
}


#Preview {
    
    let api = MoviesAPI(client: APIClient())
    //    MoviesHomeView(api: api)
    MoviesHomeView(api: api, repository: MovieRepository(local: MovieCoreDataDataSource(context: PersistenceController.shared.container.viewContext)))
}
