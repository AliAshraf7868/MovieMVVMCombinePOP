//
//  SavedMoviesView.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import SwiftUI

struct SavedMoviesView: View {
    @StateObject var viewModel: SavedMoviesViewModel

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.savedMovies.isEmpty {
                    VStack {
                        Text("No saved movies yet.")
                            .font(.headline)
                            .padding(.top, 100)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.savedMovies) { movie in
                            NavigationLink(destination:
                                MovieDetailView(
                                    presenter: MovieDetailPresenter(movie: movie),
                                    isSaved: viewModel.isMovieSaved(movie),
                                    onSaveTapped: {
                                        viewModel.toggleSave(movie: movie)
                                    }
                                )
                            ) {
                                MoviePosterView(
                                    movie: movie,
                                    isSaved: viewModel.isMovieSaved(movie),
                                    onSaveTapped: {
                                        viewModel.toggleSave(movie: movie)
                                    }
                                )
                            }

                            
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Saved Movies")
            .onAppear {
                viewModel.loadSavedMovies()
            }
        }
    }
}


#Preview {
    
    let savedMoview = SavedMoviesViewModel(movieRepo: MovieRepository(local: MovieCoreDataDataSource(context: PersistenceController.shared.container.viewContext)))
    SavedMoviesView(viewModel: savedMoview)
}
