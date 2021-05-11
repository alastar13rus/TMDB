//
//  TVSeasonListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import Foundation
import RxSwift
import RxRelay

class TVSeasonListViewModel: DetailViewModelType {
    
//    MARK: - Properties
    let networkManager: NetworkManagerProtocol
    let disposeBag = DisposeBag()
    weak var coordinator: Coordinator?
    
    let mediaID: String
    let input = Input()
    let output = Output()
    
    struct Input {
        
    }
    
    struct Output {
        let sectionedItems = BehaviorRelay<[TVSeasonCellViewModelMultipleSection]>(value: [])
    }
    
    
//    MARK: - Init
    required init(with detailID: String, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.mediaID = detailID
        
        setupOutput()
    }
    
//    MARK: - Methods
    fileprivate func setupOutput() {
        fetch { [weak self] (tvDetail) in
            guard let self = self else { return }
            let sections = self.configureSections(from: tvDetail)
            self.output.sectionedItems.accept(sections)
        }
        
    }
    
    fileprivate func configureSections(from model: TVDetailModel) -> [TVSeasonCellViewModelMultipleSection] {
        let title = "Список сезонов"
        let items: [TVSeasonCellViewModelMultipleSection.SectionItem] =
            model.seasons.map { .season(vm: TVSeasonCellViewModel($0)) }
        let sections: [TVSeasonCellViewModelMultipleSection] = [
            .seasonSection(title: title, items: items)
        ]
        return sections
    }
    
    fileprivate func fetch(completion: @escaping (TVDetailModel) -> Void) {
        networkManager.request(TmdbAPI.tv(.details(mediaID: mediaID, appendToResponse: [], includeImageLanguage: []))) { (result: Result<TVDetailModel, Error>) in
            switch result {
            case .success(let tvDetail):
                completion(tvDetail)
            case .failure: break
            }
        }
    }
    
}
