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

    @State private var showAlert = false
    var onResetFlow: () -> Void

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    init(api: MoviesAPI, repository: MovieRepositoryProtocol, onResetFlow: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: MoviesViewModel(api: api, repository: repository))
        self.onResetFlow = onResetFlow
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                UpcomingMoviesSection(viewModel: viewModel)
                PopularMoviesSection(viewModel: viewModel, columns: columns)
            }
        }
        .navigationTitle("Movies")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Would you like to change flow?"),
                primaryButton: .destructive(Text("Yes")) {
                    onResetFlow()
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            if viewModel.isFirstLoad {
                viewModel.fetchUpcomingMovies()
                viewModel.fetchPopularMovies()
                viewModel.isFirstLoad = false
            }
        }
    }
}



// MARK: - Date Formatters
extension DateFormatter {
    static let releaseDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
}


//struct MoviesHomeView: View {
//    @StateObject private var viewModel: MoviesViewModel
//
//    let columns = [
//        GridItem(.flexible(), spacing: 12),
//        GridItem(.flexible(), spacing: 12)
//    ]
//
//    init(api: MoviesAPI, repository: MovieRepositoryProtocol) {
//        _viewModel = StateObject(wrappedValue: MoviesViewModel(api: api, repository: repository))
//    }
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                
//                VStack(alignment: .leading, spacing: 20) {
//                    if viewModel.isLoadingUpcoming {
//                        ProgressView("Loading upcoming movies...")
//                            .padding(.leading)
//                    } else if let error = viewModel.upcomingError {
//                        VStack {
//                            Text("Error loading upcoming movies: \(error)")
//                                .foregroundColor(.red)
//                                .multilineTextAlignment(.center)
//                            Button("Retry") {
//                                viewModel.fetchUpcomingMovies()
//                            }
//                            .padding()
//                        }
//                    } else {
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 16) {
//                                ForEach(viewModel.upcomingMovies) { movie in
//                                    NavigationLink(destination:
//                                        MovieDetailView(
//                                            viewModel: MovieDetailViewModel(
//                                                movie: movie,
//                                                repository: viewModel.repository
//                                            )
//                                        )
//                                    ) {
//                                        VStack {
//                                            MoviePosterView(
//                                                movie: movie,
//                                                isSaved: viewModel.isMovieSaved(movie.id),
//                                                onSaveTapped: {
//                                                    viewModel.toggleSave(movie: movie)
//                                                }
//                                            )
//                                            .frame(width: 120, height: 180)
//                                        }
//                                    }
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                        .frame(height: 200)
//                        .onAppear {
//                            if viewModel.upcomingMovies.isEmpty {
//                                viewModel.fetchUpcomingMovies()
//                            }
//                        }
//                    }
//                    if viewModel.isLoadingPopular {
//                        ProgressView("Loading popular movies...")
//                            .padding(.top, 20)
//                    } else if let error = viewModel.popularError {
//                        VStack {
//                            Text("Error loading popular movies: \(error)")
//                                .foregroundColor(.red)
//                                .multilineTextAlignment(.center)
//                            Button("Retry") {
//                                viewModel.fetchPopularMovies()
//                            }
//                            .padding()
//                        }
//                    } else {
//                        LazyVGrid(columns: columns, spacing: 16) {
//                            ForEach(viewModel.popularMovies) { movie in
//                                NavigationLink(destination:
//                                    MovieDetailView(
//                                        viewModel: MovieDetailViewModel(
//                                            movie: movie,
//                                            repository: viewModel.repository
//                                        )
//                                    )
//                                ) {
//                                    MoviePosterView(
//                                        movie: movie,
//                                        isSaved: viewModel.isMovieSaved(movie.id),
//                                        onSaveTapped: {
//                                            viewModel.toggleSave(movie: movie)
//                                        }
//                                    )
//                                }
//                                .onAppear {
//                                    viewModel.loadMoreMoviesIfNeeded(currentMovie: movie)
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//                .navigationTitle("Movies")
//                .navigationBarTitleDisplayMode(.automatic)
//            }
//        }
//        .onAppear {
//            if viewModel.popularMovies.isEmpty {
//                viewModel.fetchPopularMovies()
//            }
//            if viewModel.upcomingMovies.isEmpty {
//                viewModel.fetchUpcomingMovies()
//            }
//        }
//    }
//}

//struct HomeHeaderView: View {
//    
//    @Binding var viewModel: MoviesViewModel
//    
//    var body: some View {
//        if viewModel.isLoadingUpcoming {
//            ProgressView("Loading upcoming movies...")
//                .padding(.leading)
//        } else if let error = viewModel.upcomingError {
//            VStack {
//                Text("Error loading upcoming movies: \(error)")
//                    .foregroundColor(.red)
//                    .multilineTextAlignment(.center)
//                Button("Retry") {
//                    viewModel.fetchUpcomingMovies()
//                }
//                .padding()
//            }
//        } else {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 16) {
//                    ForEach(viewModel.upcomingMovies) { movie in
//                        NavigationLink(destination:
//                            MovieDetailView(
//                                viewModel: MovieDetailViewModel(
//                                    movie: movie,
//                                    repository: viewModel.repository
//                                )
//                            )
//                        ) {
//                            VStack {
//                                MoviePosterView(
//                                    movie: movie,
//                                    isSaved: viewModel.isMovieSaved(movie.id),
//                                    onSaveTapped: {
//                                        viewModel.toggleSave(movie: movie)
//                                    }
//                                )
//                                .frame(width: 120, height: 180)
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .frame(height: 200)
//            .onAppear {
//                if viewModel.upcomingMovies.isEmpty {
//                    viewModel.fetchUpcomingMovies()
//                }
//            }
//        }
//    }
//}


#Preview {
    
    let api = MoviesAPI(client: APIClient())
    //    MoviesHomeView(api: api)
//    MoviesHomeView(api: api, repository: MovieRepository(local: MovieCoreDataDataSource(context: PersistenceController.shared.container.viewContext)), onResetFlow: nil)
}
