//
//  CDFavoriteTV+CoreDataProperties.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 06.06.2021.
//
//

import Foundation
import CoreData

extension CDFavoriteTV {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavoriteTV> {
        return NSFetchRequest<CDFavoriteTV>(entityName: "CDFavoriteTV")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var firstAirDate: String?
    @NSManaged public var genreIds: String
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var originalLanguage: String
    @NSManaged public var originalName: String
    @NSManaged public var originCountry: String
    @NSManaged public var overview: String
    @NSManaged public var popularity: Float
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Float
    @NSManaged public var voteCount: Int32

}

extension CDFavoriteTV: Identifiable {

}
