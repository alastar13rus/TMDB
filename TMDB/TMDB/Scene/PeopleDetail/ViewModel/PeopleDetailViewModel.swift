//
//  PeopleDetailViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import Foundation
import RxSwift
import RxRelay

class PeopleDetailViewModel: DetailViewModelType {
    
    
//    MARK: - Properties
    let detailID: String
    let networkManager: NetworkManagerProtocol
    weak var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let sectionTypeDidChange = BehaviorRelay<Void>(value: ())
    }
    
    struct Output {
        let name = BehaviorRelay<String>(value: "")
        let sectionedItems = BehaviorRelay<[PeopleDetailCellViewModelMultipleSection]>(value: [])
    }
    
    
//    MARK: - Init
    required init(with detailID: String, networkManager: NetworkManagerProtocol) {
        self.detailID = detailID
        self.networkManager = networkManager
        
        setupOutput()
    }
    
//    MARK: - Methods
    
    fileprivate func setupOutput() {
        self.fetch { [weak self] (peopleDetail) in
            guard let self = self else { return }
            let sections = self.configureSections(from: peopleDetail)
            self.output.sectionedItems.accept(sections)
        }
    }
    
    fileprivate func fetch(completion: @escaping (PeopleDetailModel) -> Void) {
        networkManager.request(TmdbAPI.people(.details(personID: detailID, appendToResponse: [.combinedCredits, .images]))) { (result: Result<PeopleDetailModel, Error>) in
            switch result {
            case .success(let peopleDetail):
                completion(peopleDetail)
            case .failure:
                break
            }
        }
    }
    
    fileprivate func configureSections(from model: PeopleDetailModel) -> [PeopleDetailCellViewModelMultipleSection] {
        
        let sections = [PeopleDetailCellViewModelMultipleSection]()
        
        return sections
            .buildSection(withModel: model, andAction: configureProfileWrapperSection(with:sections:))
            .buildSection(withModel: model, andAction: configureImageListSection(with:sections:))
            .buildSection(withModel: model, andAction: configureBioSection(with:sections:))
            .buildSection(withModel: model, andAction: configureBestMediaSection(with:sections:))
        
    }
    
    fileprivate func configureProfileWrapperSection(with model: PeopleDetailModel, sections: [PeopleDetailCellViewModelMultipleSection]) -> [PeopleDetailCellViewModelMultipleSection] {
        let title = ""
        var sections = sections
        
        let profileWrapperSection: PeopleDetailCellViewModelMultipleSection = .profileWrapperSection(title: title, items: [.profileWrapper(vm: PeopleProfileWrapperCellViewModel(model))])
        
        sections.append(profileWrapperSection)
        return sections
    }
    
    fileprivate func configureImageListSection(with model: PeopleDetailModel, sections: [PeopleDetailCellViewModelMultipleSection]) -> [PeopleDetailCellViewModelMultipleSection] {
        let title = "Фото"
        guard var images = model.images?.profiles else { return sections }
        images.removeFirst()
        guard !images.isEmpty else { return sections }
        var sections = sections
        
        let items: [PeopleDetailCellViewModelMultipleSection.SectionItem] = [.imageList(vm: PeopleImageListViewModel(title: title, items: images.map { PeopleImageCellViewModel($0) }))]
        
        let imageListSection: PeopleDetailCellViewModelMultipleSection = .imageListSection(title: title, items: items)
        
        sections.append(imageListSection)
        return sections
    }
    
    fileprivate func configureBioSection(with model: PeopleDetailModel, sections: [PeopleDetailCellViewModelMultipleSection]) -> [PeopleDetailCellViewModelMultipleSection] {
        let title = "Биография"
        var sections = sections
        
        let bioSection: PeopleDetailCellViewModelMultipleSection = .bioSection(title: title, items: [.bio(vm: PeopleBioCellViewModel(model))])
        
        if !bioSection.isEmpty { sections.append(bioSection) }
        return sections
    }
    
    fileprivate func configureBestMediaSection(with model: PeopleDetailModel, sections: [PeopleDetailCellViewModelMultipleSection]) -> [PeopleDetailCellViewModelMultipleSection] {
        let title = "Лучшие работы"
        var sections = sections
        
        guard let cast = model.combinedCredits?.cast, let crew = model.combinedCredits?.crew else { return sections }
        
        let castInMovie: [CreditInMediaCellViewModelMultipleSection.SectionItem] = cast.filter { $0.mediaType.rawValue == MediaType.movie.rawValue }.map { .creditInMovie(vm: CreditInMediaViewModel($0)) }
        
        let crewInMovie: [CreditInMediaCellViewModelMultipleSection.SectionItem] = crew.filter { $0.mediaType.rawValue == MediaType.movie.rawValue }.map { .creditInMovie(vm: CreditInMediaViewModel($0)) }
        
        let castInTV: [CreditInMediaCellViewModelMultipleSection.SectionItem] = cast.filter { $0.mediaType.rawValue == MediaType.tv.rawValue }.map { .creditInTV(vm: CreditInMediaViewModel($0)) }
        
        let crewInTV: [CreditInMediaCellViewModelMultipleSection.SectionItem] = crew.filter { $0.mediaType.rawValue == MediaType.tv.rawValue }.map { .creditInTV(vm: CreditInMediaViewModel($0)) }
        
        
        let movieSectionItems: [CreditInMediaCellViewModelMultipleSection.SectionItem] = Array(Array(Set(castInMovie + crewInMovie)).sorted(by: >).prefix(5))
        
        let tvSectionItems: [CreditInMediaCellViewModelMultipleSection.SectionItem] = Array(Array(Set(castInTV + crewInTV)).sorted(by: >).prefix(5))
        
        let bestMediaSection: PeopleDetailCellViewModelMultipleSection = .bestMediaSection(
            title: title,
            items:
                [
                    PeopleDetailCellViewModelMultipleSection.SectionItem.bestMedia(vm: PeopleBestMediaListViewModel(title: title, items: movieSectionItems + tvSectionItems, coordinator: coordinator))
                ]
        )
        
        sections.append(bestMediaSection)
        return sections
    }
    
    
    
}
