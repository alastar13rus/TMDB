//
//  MediaRecommendationListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 27.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

class MediaRecommendationListViewModel: AnimatableSectionModelType {
    
//    MARK: - Properties
    let title: String
    let items: [MediaCellViewModel]
    let disposedBag = DisposeBag()
    weak var coordinator: Coordinator?
    weak var networkManager: NetworkManagerProtocol?
    
    var sectionedItems: Observable<[MediaCellViewModelMultipleSection]> {
        
        var movieItems = [MediaCellViewModelMultipleSection.SectionItem]()
        var tvItems = [MediaCellViewModelMultipleSection.SectionItem]()
        
        _ = items.map {
            switch $0.mediaType {
            case .movie:
                movieItems = items.map { MediaCellViewModelMultipleSection.SectionItem.movie(vm: $0) }
            case .tv:
                tvItems = items.map { MediaCellViewModelMultipleSection.SectionItem.tv(vm: $0) }
            }
        }
        
        let sections: [MediaCellViewModelMultipleSection] = [
            .movieSection(title: "Фильмы", items: movieItems),
            .tvSection(title: "Сериалы", items: tvItems)
        ]
        return .just(sections)
    }
    
    let selectedItem = PublishRelay<MediaCellViewModelMultipleSection.SectionItem>()
    
    
//    MARK: - Init
    required init(original: MediaRecommendationListViewModel, items: [MediaCellViewModel]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [MediaCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    convenience init(title: String, items: [MediaCellViewModel], coordinator: Coordinator?, networkManager: NetworkManagerProtocol?) {
        self.init(title: title, items: items)
        
        self.coordinator = coordinator
        self.networkManager = networkManager
        subscribing()
    }
    
//    MARK: - Methods
    fileprivate func subscribing() {
        selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            switch $0 {
            case .movie(let vm):
                guard let coordinator = self.coordinator as? MovieListCoordinator else { return }
                coordinator.toDetail(with: vm.id)
            case .tv(let vm):
                guard let coordinator = self.coordinator as? TVListCoordinator else { return }
                coordinator.toDetail(with: vm.id)
            }
        }).disposed(by: disposedBag)
    }

}

extension MediaRecommendationListViewModel: IdentifiableType {
    var identity: String { return title }
}

extension MediaRecommendationListViewModel: Equatable {
    static func == (lhs: MediaRecommendationListViewModel, rhs: MediaRecommendationListViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
