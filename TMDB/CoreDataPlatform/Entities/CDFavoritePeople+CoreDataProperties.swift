//
//  CDFavoritePeople+CoreDataProperties.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 06.06.2021.
//
//

import Foundation
import CoreData

extension CDFavoritePeople {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavoritePeople> {
        return NSFetchRequest<CDFavoritePeople>(entityName: "CDFavoritePeople")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var popularity: Float
    @NSManaged public var profilePath: String?

}

extension CDFavoritePeople: Identifiable {

}
