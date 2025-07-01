//
//  MovieProjectApp.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import SwiftUI

@main
struct MovieProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
