//
//  CoreDataAgent.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 03.06.2021.
//

import Foundation
import CoreData

public protocol DBAgent {
    func query<T: CoreDataRepresentable>(with predicate: NSPredicate?,
                                         sortDescriptors: [NSSortDescriptor]?) -> [T] where T == T.CoreDataType.DomainType
    func fetchAll<T: CoreDataRepresentable>(entityType: T.Type) -> [T] where T == T.CoreDataType.DomainType 
    func save<T: CoreDataRepresentable>(entity: T) where T == T.CoreDataType.DomainType
    func delete<T: CoreDataRepresentable>(entity: T) where T == T.CoreDataType.DomainType
}

public final class CoreDataAgent: DBAgent {
    private let context: NSManagedObjectContext
    
    public  init(with context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func query<T: CoreDataRepresentable>(
        with predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil) -> [T] where T == T.CoreDataType.DomainType {
        let request = T.CoreDataType.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        context.perform {
            do {
                try frc.performFetch()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        let results = frc.fetchedObjects.map { (persistableItems) -> [T] in
            persistableItems.map { (persistableItem) -> T in
                persistableItem.asDomain()
            }
        }
        return results ?? []
    }
    
    public func find<T: CoreDataRepresentable>(entity: T) -> T.CoreDataType? where T == T.CoreDataType.DomainType {
        let request = T.CoreDataType.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", entity.uid)
            
        do {
            let objects = try context.fetch(request)
            guard !objects.isEmpty else { return nil }
            return objects.first
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func fetch<T: CoreDataRepresentable>(entity: T) -> T? where T == T.CoreDataType.DomainType {
        let request = T.CoreDataType.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", entity.uid)
        do {
            let objects = try context.fetch(request)
            guard !objects.isEmpty else { return nil }
            return objects.first!.asDomain()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func fetchAll<T: CoreDataRepresentable>(entityType: T.Type) -> [T] where T == T.CoreDataType.DomainType {
        let request = T.CoreDataType.fetchRequest()
        var cdFetchedItems = [T.CoreDataType]()
        do {
            cdFetchedItems = try context.fetch(request)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        return cdFetchedItems.map { $0.asDomain() }
    }

    public func save<T: CoreDataRepresentable>(entity: T) where T == T.CoreDataType.DomainType {
        do {
            if let cdObject: T.CoreDataType = find(entity: entity),
                  let object = cdObject as? NSManagedObject {
                context.delete(object)
            }
            
            context.insert(entity.asCoreDataObject(with: context) as! NSManagedObject)
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func delete<T: CoreDataRepresentable>(entity: T) where T == T.CoreDataType.DomainType {
        do {
            guard let cdObject: T.CoreDataType = find(entity: entity),
                  let object = cdObject as? NSManagedObject else { return }
            
            context.delete(object)
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
