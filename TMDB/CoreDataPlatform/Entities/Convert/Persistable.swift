//
//  Persistable.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 03.06.2021.
//

import Foundation
import CoreData

public protocol Persistable: NSFetchRequestResult, DomainConvertible {
    static var entityName: String { get }
    static func fetchRequest() -> NSFetchRequest<Self>
}
