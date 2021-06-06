//
//  CoreDataRepresentable.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 03.06.2021.
//

import Foundation
import CoreData

public protocol CoreDataRepresentable {
    associatedtype CoreDataType: Persistable
    
    var uid: Int { get }
    func asCoreDataObject(with context: NSManagedObjectContext) -> NSManagedObject
    
    
}
