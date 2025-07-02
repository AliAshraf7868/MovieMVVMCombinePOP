//
//  CoreDataFactory.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation
import CoreData

final class CoreDataFactory {
    static let shared = CoreDataFactory()
    private init() {}
    let persistence = PersistenceController.shared
    var context: NSManagedObjectContext { persistence.container.viewContext }
}
