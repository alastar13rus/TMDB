//
//  TVDetailViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

class TVDetailViewModel: DetailViewModelType {
    
//    MARK: - Properties
    let networkManager: NetworkManagerProtocol
    let detailID: String
    weak var coordinator: Coordinator?
    
    
//    MARK: - Input
    
    struct Input {
        
    }
    
    let input = Input()
    
    
    
//    MARK: - Output
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let backdropImageData = BehaviorRelay<Data?>(value: nil)
        let sectionedItems = BehaviorRelay<[TVDetailCellViewModelMultipleSection]>(value: [])
    }
    
    let output = Output()
    
//    MARK: - Init
    required init(with detailID: String, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.detailID = detailID
        
        fetch { [weak self] (tvDetail) in
            guard let self = self else { return }
            
            let sections = self.configureSections(from: tvDetail)
            self.output.sectionedItems.accept(sections)
            
        }
        
    }
    
//    MARK: - Methods
    
    func fetch(completion: @escaping (TVDetailModel) -> Void) {
        self.networkManager.request(TmdbAPI.tv(.details(mediaID: detailID, appendToResponse: [.credits]))) { (result: Result<TVDetailModel, Error>) in
            
            switch result {
            case .success(let tvDetail):
                completion(tvDetail)
                
            case .failure(_): break
            }
        }
    }
    
    private func refreshOutput(with section: TVDetailCellViewModelMultipleSection) {
        
        switch section.items[0] {
        case .tvPosterWrapper(let vm):
            self.output.title.accept(vm.title)
            
            guard let backdropPath = vm.backdropPath else { self.output.backdropImageData.accept(nil); return }
            guard let backdropAbsolutePath = ImageURL.backdrop(.w780, backdropPath).fullURL else { self.output.backdropImageData.accept(nil); return }
            
            backdropAbsolutePath.downloadImageData(completion: { (imageData) in
                guard let imageData = imageData else {
                    self.output.backdropImageData.accept(nil)
                    return
                }
                self.output.backdropImageData.accept(imageData)
            })
        
        default: break
        }
    }
    
    private func configureSections(from model: TVDetailModel) -> [TVDetailCellViewModelMultipleSection] {
        
        let sections = [TVDetailCellViewModelMultipleSection]()
        
        return sections
            .buildSections(withModel: model, andAction: self.configureTVPosterWrapperSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureTVOverviewSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureTVRuntimeSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureTVGenresSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureTVStatusSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureTVCreatorsSection(withModel:sections:))
            .buildSections(withModel: model, andAction: self.configureTVCastListSection(withModel:sections:))
        
    }
    
    fileprivate func configureTVPosterWrapperSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {

        var sections = sections

        let tvPosterWrapperSection: TVDetailCellViewModelMultipleSection =
            .tvPosterWrapperSection(
                title: "Poster",
                items: [.tvPosterWrapper(vm: TVPosterWrapperCellViewModel(model))])

        sections.append(tvPosterWrapperSection)

        refreshOutput(with: tvPosterWrapperSection)

        return sections
    }

    
    fileprivate func configureTVOverviewSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let tvOverviewSection: TVDetailCellViewModelMultipleSection =
            .tvPosterWrapperSection(
                title: "Overview",
                items: [.tvOverview(vm: MediaOverviewCellViewModel(model))])
        
        sections.append(tvOverviewSection)
        return sections
    }
    
    fileprivate func configureTVRuntimeSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let tvRuntimeSection: TVDetailCellViewModelMultipleSection =
            .tvRuntimeSection(
                title: "Продолжительность",
                items: [.tvRuntime(vm: TVRuntimeCellViewModel(model))])
        
        sections.append(tvRuntimeSection)
        return sections
    }
    
    fileprivate func configureTVGenresSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let tvGenresSection: TVDetailCellViewModelMultipleSection =
            .tvGenresSection(
                title: "Жанры",
                items: [.tvGenres(vm: GenresCellViewModel(model))])
        
        sections.append(tvGenresSection)
        return sections
    }
    
    fileprivate func configureTVStatusSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        let tvStatusSection: TVDetailCellViewModelMultipleSection =
            .tvStatusSection(
                title: "Статус",
                items: [.tvStatus(vm: MediaStatusCellViewModel(model))])
        
        sections.append(tvStatusSection)
        return sections
    }
    
    fileprivate func configureTVCreatorsSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        if !model.createdBy.isEmpty {
            
            let tvCreatorsSection: TVDetailCellViewModelMultipleSection =
                .tvCreatorsSection(
                    title: "Создатели",
                    items: model.createdBy.map { .tvCreators(vm: CreatorWithPhotoCellViewModel($0)) })
            
            sections.append(tvCreatorsSection)
        }
        return sections
    }
    
    fileprivate func configureTVCastListSection(withModel model: TVDetailModel, sections: [TVDetailCellViewModelMultipleSection]) -> [TVDetailCellViewModelMultipleSection] {
        
        var sections = sections
        
        if let castList = model.credits?.cast, !castList.isEmpty {
            let title = "Актеры"
            let tvCastListSection: TVDetailCellViewModelMultipleSection =
                .tvCastListSection(title: title, items: [.tvCastList(vm: CastListViewModel(title: title, items: castList.map { CastCellViewModel($0) }))])
            
            sections.append(tvCastListSection)
        }
        return sections
    }
    
}

extension Array where Array.Element: AnimatableSectionModelType {
    
    func buildSections<T, U: MediaDetailProtocol>(withModel model: U,
                             andAction action: ((U, [T]) -> [T])) -> [T] {
        guard let self = self as? [T] else { return [] }
        return action(model, self as [T])
    }

}
