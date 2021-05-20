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
import Domain

class MediaTrailerListViewModel {
    
//    MARK: - Properties
    weak var coordinator: Coordinator?
    
    let useCaseProvider: Domain.UseCaseProvider
    
    let disposeBag = DisposeBag()
    let mediaID: String
    var seasonNumber: String = ""
    var episodeNumber: String = ""
    let mediaType: MediaType
    
    var useCase: Domain.UseCase {
        switch mediaType {
        case .movie: return useCaseProvider.makeMovieDetailUseCase()
        case .tv: return useCaseProvider.makeTVDetailUseCase()
        case .tvSeason: return useCaseProvider.makeTVSeasonDetailUseCase()
        case .tvEpisode: return useCaseProvider.makeTVEpisodeDetailUseCase()
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
    init(with mediaID: String, mediaType: MediaType, useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider

        self.mediaID = mediaID
        self.mediaType = mediaType
        
        setupOutput()
    }
    
    init(with mediaID: String, mediaType: MediaType, seasonNumber: String, useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        
        self.mediaID = mediaID
        self.mediaType = mediaType
        self.seasonNumber = seasonNumber
        
        setupOutput()
    }
    
    init(with mediaID: String, mediaType: MediaType, seasonNumber: String, episodeNumber: String, useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        
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
        
        switch mediaType {
        case .movie:
            let useCase = useCaseProvider.makeMovieDetailUseCase()
            useCase.videos(mediaID: mediaID) { (response: Result<VideoList, Error>) in
                if case .success(let trailerList) = response { completion(trailerList) }
            }
        case .tv:
            let useCase = useCaseProvider.makeTVDetailUseCase()
            useCase.videos(mediaID: mediaID) { (response: Result<VideoList, Error>) in
                if case .success(let trailerList) = response { completion(trailerList) }
            }
        case .tvSeason:
            let useCase = useCaseProvider.makeTVSeasonDetailUseCase()
            useCase.videos(mediaID: mediaID, seasonNumber: seasonNumber) { (response: Result<VideoList, Error>) in
                if case .success(let trailerList) = response { completion(trailerList) }
            }
        case .tvEpisode:
            let useCase = useCaseProvider.makeTVEpisodeDetailUseCase()
            useCase.videos(mediaID: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber) { (response: Result<VideoList, Error>) in
                if case .success(let trailerList) = response { completion(trailerList) }
            }
        }
    }
    
}
