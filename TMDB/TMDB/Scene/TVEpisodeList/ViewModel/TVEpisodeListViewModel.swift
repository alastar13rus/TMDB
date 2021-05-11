//
//  TVEpisodeListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.05.2021.
//

import Foundation
import RxSwift
import RxRelay

class TVEpisodeListViewModel: DetailWithParamViewModelType {
    
//    MARK: - Properties
    let networkManager: NetworkManagerProtocol
    let disposeBag = DisposeBag()
    weak var coordinator: Coordinator?
    
    let mediaID: String
    var seasonNumber: String = ""
    let input = Input()
    let output = Output()
    
    struct Input {
        
    }
    
    struct Output {
        let sectionedItems = BehaviorRelay<[TVEpisodeCellViewModelMultipleSection]>(value: [])
    }
    
    
//    MARK: - Init
    required init(with detailID: String, networkManager: NetworkManagerProtocol, params: [String: String]) {
        self.networkManager = networkManager
        self.mediaID = detailID
        if let seasonNumber = params["seasonNumber"] { self.seasonNumber = seasonNumber }
        
        setupOutput()
    }
    
//    MARK: - Methods
    fileprivate func setupOutput() {
        fetch { [weak self] (tvSeasonDetail) in
            guard let self = self else { return }
            let sections = self.configureSections(from: tvSeasonDetail)
            self.output.sectionedItems.accept(sections)
        }
        
    }
    
    fileprivate func configureSections(from model: TVSeasonDetailModel) -> [TVEpisodeCellViewModelMultipleSection] {
        let title = "Список эпизодов"
        let items: [TVEpisodeCellViewModelMultipleSection.SectionItem] =
            model.episodes.map { .episode(vm: TVEpisodeCellViewModel($0)) }
        let sections: [TVEpisodeCellViewModelMultipleSection] = [
            .episodeSection(title: title, items: items)
        ]
        return sections
    }
    
    fileprivate func fetch(completion: @escaping (TVSeasonDetailModel) -> Void) {
        networkManager.request(TmdbAPI.tv(.season(mediaID: mediaID, seasonNumber: seasonNumber, appendToResponse: [ .images, .videos ], includeImageLanguage: []))) { (result: Result<TVSeasonDetailModel, Error>) in
            switch result {
            case .success(let tvSeasonDetail):
                completion(tvSeasonDetail)
            case .failure: break
            }
        }
    }
    
}
