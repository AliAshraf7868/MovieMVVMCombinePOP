//
//  SearchMoviesView.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchMoviesView: View {
    @StateObject private var viewModel: SearchMoviesViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    init(api: MoviesAPI, recentRepo: RecentSearchRepositoryProtocol, movieRepo: MovieRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: SearchMoviesViewModel(
            api: api, recentRepo: recentRepo, movieRepo: movieRepo
        ))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TextField("Search movies...", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .padding(.top)
                    .submitLabel(.search)
                    .onSubmit {
                        viewModel.submitSearch()
                    }
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                if viewModel.searchText.isEmpty {
                    List {
                        Section(header: Text("Recent Searches").font(.headline)) {
                            ForEach(viewModel.recentSearches, id: \.self) { recent in
                                Button {
                                    viewModel.selectRecentSearch(recent)
                                } label: {
                                    HStack {
                                        Text(recent)
                                        Spacer()
                                        Button(action: {
                                            viewModel.deleteRecent(query: recent)
                                        }) {
                                            Image(systemName: "xmark")
                                                .foregroundStyle(.black)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            .onDelete(perform: viewModel.deleteRecent)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .padding()
                } else if viewModel.isLoading {
                    Spacer()
                    ProgressView("Searching...")
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.searchResults) { movie in
                                NavigationLink(destination:
                                                MovieDetailView(
                                                    viewModel: MovieDetailViewModel(
                                                        movie: movie,
                                                        repository: viewModel.movieRepo
                                                    )
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
            }
            .navigationTitle("Search Movies")
        }
    }
}




#Preview {
    let api = MoviesAPI(client: APIClient())
    let repository = RecentSearchCoreDataRepository()
    SearchMoviesView(api: api, recentRepo: repository, movieRepo: MovieRepository(local: MovieCoreDataDataSource(context: PersistenceController.shared.container.viewContext)))
}

