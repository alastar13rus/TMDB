//
//  TVSeasonListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import Foundation
import RxSwift
import RxRelay
import Swinject
import Domain

class TVSeasonListViewModel {
    
//    MARK: - Properties
    let useCaseProvider: Domain.UseCaseProvider
    
    let disposeBag = DisposeBag()
    weak var coordinator: Coordinator?
    
    let mediaID: String
    let input = Input()
    let output = Output()
    
    struct Input {
        let selectedItem = PublishRelay<TVSeasonCellViewModelMultipleSection.SectionItem>()
    }
    
    struct Output {
        let sectionedItems = BehaviorRelay<[TVSeasonCellViewModelMultipleSection]>(value: [])
    }
    
    
//    MARK: - Init
    required init(with mediaID: String, useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider

        self.mediaID = mediaID
        
        setupInput()
        setupOutput()
    }
    
//    MARK: - Methods
    fileprivate func setupInput() {
        input.selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self, let coordinator = self.coordinator as? TVSeasonFlowCoordinator else { return }
            switch $0 {
            case .season(let vm): coordinator.toDetail(with: self.mediaID, seasonNumber: vm.seasonNumber)
            default: break
            }
        }).disposed(by: disposeBag)
    }
    
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
        
        let useCase = useCaseProvider.makeTVDetailUseCase()
        
        useCase.details(mediaID: mediaID, appendToResponse: [], includeImageLanguage: []) { (result: Result<TVDetailModel, Error>) in
            switch result {
            case .success(let tvDetail):
                completion(tvDetail)
            case .failure: break
            }
        }
    }
    
}
