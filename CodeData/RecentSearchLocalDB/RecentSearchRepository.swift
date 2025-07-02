//
//  RecentSearchRepository.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 01/07/2025.
//

import Foundation
import CoreData

final class RecentSearchCoreDataRepository: RecentSearchRepositoryProtocol {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataFactory.shared.context) {
        self.context = context
    }

    func saveSearch(query: String) {
        
        let fetchRequest: NSFetchRequest<RecentSearchEntity> = RecentSearchEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "query ==[c] %@", query)
        
        if let existing = try? context.fetch(fetchRequest), !existing.isEmpty {
            existing.forEach { context.delete($0) }
        }

        let newSearch = RecentSearchEntity(context: context)
        newSearch.id = UUID()
        newSearch.query = query
        newSearch.createdAt = Date()

        try? context.save()
    }

    func getRecentSearches(limit: Int = 10) -> [String] {
        let request: NSFetchRequest<RecentSearchEntity> = RecentSearchEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \RecentSearchEntity.createdAt, ascending: false)]
        request.fetchLimit = limit

        let results = (try? context.fetch(request)) ?? []
        return results.map { $0.query ?? "Default" }
    }
    
    func deleteSearch(query: String) {
        let context = PersistenceController.shared.container.viewContext
        let request: NSFetchRequest<RecentSearchEntity> = RecentSearchEntity.fetchRequest()
        request.predicate = NSPredicate(format: "query == %@", query)
        if let results = try? context.fetch(request) {
            for obj in results {
                context.delete(obj)
            }
            try? context.save()
        }
    }

    
}
