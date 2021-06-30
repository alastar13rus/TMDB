//
//  CDFavoriteMovie+Extension.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 04.06.2021.
//

import Foundation
import CoreData
import Domain

extension CDFavoriteMovie: Persistable {
    
    public static var entityName: String {
        return String(describing: self)
    }
}

extension CDFavoriteMovie: DomainConvertible {
    public typealias DomainType = MovieModel

    public func asDomain() -> DomainType {
        return MovieModel(posterPath: posterPath,
                          adult: adult,
                          overview: overview,
                          releaseDate: releaseDate,
                          genreIds: genreIds.decodeToArray(with: Int.self),
                          id: Int(id),
                          originalTitle: originalTitle,
                          originalLanguage: originalLanguage,
                          title: title,
                          backdropPath: backdropPath,
                          popularity: popularity,
                          voteCount: Int(voteCount),
                          video: video,
                          voteAverage: voteAverage)
    }
}

extension MovieModel: CoreDataRepresentable {

    public typealias CoreDataType = CDFavoriteMovie
    
    public var uid: Int { id }
    
    public func asCoreDataObject(with context: NSManagedObjectContext) -> NSManagedObject {
        
        let cdFavoriteMovie = CDFavoriteMovie(context: context)
        
        cdFavoriteMovie.posterPath = self.posterPath
        cdFavoriteMovie.adult = self.adult
        cdFavoriteMovie.overview = self.overview
        cdFavoriteMovie.releaseDate = self.releaseDate
        cdFavoriteMovie.genreIds = self.genreIds.encodeToString()
        cdFavoriteMovie.id = Int32(self.id)
        cdFavoriteMovie.originalTitle = self.originalTitle
        cdFavoriteMovie.originalLanguage = self.originalLanguage
        cdFavoriteMovie.title = self.title
        cdFavoriteMovie.backdropPath = self.backdropPath
        cdFavoriteMovie.popularity = self.popularity ?? 0
        cdFavoriteMovie.voteCount = Int32(self.voteCount)
        cdFavoriteMovie.video = self.video
        cdFavoriteMovie.voteAverage = self.voteAverage
        
        return cdFavoriteMovie
    }
}
