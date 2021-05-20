//
//  TVEpisodeListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.05.2021.
//

import Foundation
import RxSwift
import RxRelay
import Swinject
import Domain

class TVEpisodeListViewModel {
    
//    MARK: - Properties
    let useCaseProvider: Domain.UseCaseProvider
    
    let disposeBag = DisposeBag()
    weak var coordinator: Coordinator?
    
    let mediaID: String
    let seasonNumber: String
    let input = Input()
    let output = Output()
    
    struct Input {
        let selectedItem = PublishRelay<TVEpisodeCellViewModelMultipleSection.SectionItem>()
    }
    
    struct Output {
        let sectionedItems = BehaviorRelay<[TVEpisodeCellViewModelMultipleSection]>(value: [])
    }
    
    
//    MARK: - Init
    required init(with mediaID: String, seasonNumber: String, useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        self.mediaID = mediaID
        self.seasonNumber = seasonNumber
        
        setupInput()
        setupOutput()
    }
    
//    MARK: - Methods
    fileprivate func setupInput() {
        input.selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self, let coordinator = self.coordinator as? TVSeasonFlowCoordinator else { return }
            switch $0 {
            case .episode(let vm): coordinator.toEpisode(with: self.mediaID, seasonNumber: vm.seasonNumber, episodeNumber: vm.episodeNumber)
            default: break
            }
        }).disposed(by: disposeBag)
    }
    
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
        
        let useCase = useCaseProvider.makeTVSeasonDetailUseCase()
        useCase.details(mediaID: mediaID, seasonNumber: seasonNumber, appendToResponse: [.images, .videos], includeImageLanguage: []) { (result: Result<TVSeasonDetailModel, Error>) in
            switch result {
            case .success(let tvSeasonDetail):
                completion(tvSeasonDetail)
            case .failure: break
            }
        }
    }
    
}
