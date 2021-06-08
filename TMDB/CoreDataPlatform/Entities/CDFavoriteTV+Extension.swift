//
//  CDFavoriteTV+Extension.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation
import CoreData
import Domain

extension CDFavoriteTV: Persistable {
    
    public static var entityName: String {
        return String(describing: self)
    }
    
}

extension CDFavoriteTV: DomainConvertible {
    public typealias DomainType = TVModel

    public func asDomain() -> DomainType {
        
        return TVModel(firstAirDate: firstAirDate, originCountry: self.originCountry.decodeToArray(with: String.self), name: name, originalName: originalName, id: Int(id), popularity: popularity, voteCount: Int(voteCount), posterPath: posterPath, backdropPath: backdropPath, originalLanguage: originalLanguage, genreIds: genreIds.decodeToArray(with: Int.self), voteAverage: voteAverage, overview: overview)

    }
}

extension TVModel: CoreDataRepresentable {
   
    public typealias CoreDataType = CDFavoriteTV
    
    public var uid: Int { id }
    
    public func asCoreDataObject(with context: NSManagedObjectContext) -> NSManagedObject {
        
        let cdFavoriteTV = CDFavoriteTV(context: context)
        
        cdFavoriteTV.firstAirDate = self.firstAirDate
        cdFavoriteTV.originCountry = self.originCountry.encodeToString()
        cdFavoriteTV.name = self.name
        cdFavoriteTV.originalName = self.originalName
        cdFavoriteTV.id = Int32(self.id)
        cdFavoriteTV.popularity = self.popularity ?? 0
        cdFavoriteTV.voteCount = Int32(self.voteCount)
        cdFavoriteTV.posterPath = self.posterPath
        cdFavoriteTV.backdropPath = self.backdropPath
        cdFavoriteTV.originalLanguage = self.originalLanguage
        cdFavoriteTV.genreIds = self.genreIds.encodeToString()
        cdFavoriteTV.voteAverage = self.voteAverage
        cdFavoriteTV.overview = self.overview
        
        return cdFavoriteTV
    }
}
