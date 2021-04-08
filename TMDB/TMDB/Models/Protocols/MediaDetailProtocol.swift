//
//  MediaDetailProtocol.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation

protocol MediaDetailProtocol: Decodable {

    var genres: [GenreModel] { get }
    var id: Int { get }
    var originalLanguage: String { get }
    var overview: String { get }
    var popularity: Float { get }
    var posterPath: String? { get }
    var productionCompanies: [ProductionCompanyModel] { get }
    var status: String { get }
    var voteAverage: Float { get }
    var voteCount: Int {get }
    
}

protocol TVDetailProtocol: MediaDetailProtocol {
    
    associatedtype TVEpisodeProtocol
    associatedtype TVNetworkProtocol
    associatedtype TVSeasonProtocol
    
    var backdropPath: String? { get }
    var createdBy: [TVCreatorModel] { get }
    var episodeRunTime: [Int] { get }
    var firstAirDate: String { get }
    var inProduction: Bool { get }
    var languages: [LanguageModel] { get }
    var lastAirDate: String { get }
    var lastEpisodeToAir: TVEpisodeModel { get }
    var networks: [TVNetworkModel] { get }
    var numberOfEpisodes: Int { get }
    var numberOfSeasons: Int { get }
    var originCountry: [String] { get }
    var originalName: String { get }
    var seasons: [TVSeasonModel] { get }
    var tagline: String { get }
    var type: String { get }
    
}

