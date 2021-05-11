//
//  MediaTrailerListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation
import RxSwift
import RxRelay

class MediaTrailerListViewModel: DetailWithParamViewModelType {
    
//    MARK: - Properties
    weak var coordinator: Coordinator?
    let networkManager: NetworkManagerProtocol
    let disposeBag = DisposeBag()
    let mediaID: String
    let mediaType: MediaType
    var api: TmdbAPI {
        switch mediaType {
        case .movie:
            return TmdbAPI.movies(.videos(mediaID: mediaID))
        case .tv:
            return TmdbAPI.tv(.videos(mediaID: mediaID))
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
    required init(with detailID: String, networkManager: NetworkManagerProtocol, params: [String : String]) {
        self.networkManager = networkManager
        
        self.mediaID = detailID
        if let rawValue = params[String(describing: MediaType.self)], let mediaType = MediaType(rawValue: rawValue) {
            self.mediaType = mediaType
        } else {
            self.mediaType = .movie
        }
        
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
