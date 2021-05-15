//
//  MediaTrailerListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import Swinject

class MediaTrailerListViewModel {
    
//    MARK: - Properties
    weak var coordinator: Coordinator?
    let networkManager: NetworkManagerProtocol
    let disposeBag = DisposeBag()
    let mediaID: String
    var seasonNumber: String = ""
    var episodeNumber: String = ""
    let mediaType: MediaType
    var api: TmdbAPI {
        switch mediaType {
        case .movie:
            return TmdbAPI.movies(.videos(mediaID: mediaID))
        case .tv:
            return TmdbAPI.tv(.videos(mediaID: mediaID))
        case .tvSeason:
            return TmdbAPI.tv(.seasonVideos(mediaID: mediaID, seasonNumber: seasonNumber))
        case .tvEpisode:
            return TmdbAPI.tv(.episodeVideos(mediaID: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber))
        }
    }
    
    let input = Input()
    let output = Output()
    
    struct Input {
        
    }
    
    struct Output {
        let sectionedItems = BehaviorRelay<[MediaTrailerCellViewModelSection]>(value: [])
    }
    
//    MARK: - Init
    init(with mediaID: String, mediaType: MediaType, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.mediaID = mediaID
        self.mediaType = mediaType
        
        setupOutput()
    }
    
    init(with mediaID: String, mediaType: MediaType, seasonNumber: String, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.mediaID = mediaID
        self.mediaType = mediaType
        self.seasonNumber = seasonNumber
        
        setupOutput()
    }
    
    init(with mediaID: String, mediaType: MediaType, seasonNumber: String, episodeNumber: String, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.mediaID = mediaID
        self.mediaType = mediaType
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
        
        setupOutput()
    }
        
//    MARK: - Methods
    fileprivate func setupOutput() {
        fetch { [weak self] (trailerList) in
            guard let self = self else { return }
            let title = "Трейлеры"
            let sections: [MediaTrailerCellViewModelSection] = [
                MediaTrailerCellViewModelSection(title: title, items: trailerList.results.map {MediaTrailerCellViewModel($0)})
            ]
            self.output.sectionedItems.accept(sections)
        }
    }
    
    fileprivate func fetch(completion: @escaping (VideoList) -> Void) {
        networkManager.request(api) { (response: Result<VideoList, Error>) in
            switch response {
            case .success(let trailerList):
                completion(trailerList)
            case .failure: break
            }
        }
    }
    
}
