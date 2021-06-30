//
//  CDFavoriteMovie+CoreDataProperties.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 06.06.2021.
//
//

import Foundation
import CoreData

extension CDFavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavoriteMovie> {
        return NSFetchRequest<CDFavoriteMovie>(entityName: "CDFavoriteMovie")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var genreIds: String
    @NSManaged public var id: Int32
    @NSManaged public var originalLanguage: String
    @NSManaged public var originalTitle: String
    @NSManaged public var overview: String
    @NSManaged public var popularity: Float
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Float
    @NSManaged public var voteCount: Int32
    
}

extension CDFavoriteMovie: Identifiable {

}
