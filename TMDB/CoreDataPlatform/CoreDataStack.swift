//
//  CoreDataStack.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 03.06.2021.
//

import Foundation
import CoreData

public class CoreDataStack {
    
    public static let shared = CoreDataStack()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TMDB")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    public lazy var viewContext = persistentContainer.viewContext
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
        
    }
    
}
