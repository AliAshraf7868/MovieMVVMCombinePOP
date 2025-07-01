//
//  ContentView.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let api = MoviesAPI(client: APIClient())
    private let movieRepo = MovieRepository(local: MovieCoreDataDataSource(context: PersistenceController.shared.container.viewContext))
    private let recentRepo = RecentSearchRepository()

    var body: some View {
        TabView {
            MoviesHomeView(api: api, repository: movieRepo)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SearchMoviesView(api: api, recentRepo: recentRepo, movieRepo: movieRepo)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            SavedMoviesView(viewModel: SavedMoviesViewModel(movieRepo: movieRepo))
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}



//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

#Preview {
    ContentView()
}
