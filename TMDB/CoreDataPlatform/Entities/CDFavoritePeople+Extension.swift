//
//  CDFavoritePeople+Extension.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation
import CoreData
import Domain

extension CDFavoritePeople: Persistable {
    
    public static var entityName: String {
        return String(describing: self)
    }
    
}

extension CDFavoritePeople: DomainConvertible {
    public typealias DomainType = PeopleModel

    public func asDomain() -> DomainType {
        return PeopleModel(
            adult: adult,
            id: Int(id),
            knownFor: [],
            name: name,
            popularity: popularity,
            profilePath: profilePath)
    }
}

extension PeopleModel: CoreDataRepresentable {
    
    public typealias CoreDataType = CDFavoritePeople
    
    public var uid: Int { id }
    
    public func asCoreDataObject(with context: NSManagedObjectContext) -> NSManagedObject {
        
        let cdFavoritePeople = CDFavoritePeople(context: context)
        
        cdFavoritePeople.adult = self.adult
        cdFavoritePeople.id = Int32(self.id)
        cdFavoritePeople.name = self.name
        cdFavoritePeople.popularity = self.popularity
        cdFavoritePeople.profilePath = self.profilePath
        
        return cdFavoritePeople
    }
}
