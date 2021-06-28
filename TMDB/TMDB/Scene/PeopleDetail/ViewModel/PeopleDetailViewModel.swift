//
//  PeopleDetailViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import Domain
import NetworkPlatform

class PeopleDetailViewModel {
    
    
//    MARK: - Properties
    private let useCaseProvider: Domain.UseCaseProvider
    private let useCasePersistenceProvider: Domain.UseCasePersistenceProvider
    private let networkMonitor: Domain.NetworkMonitor

    private let peopleID: String
    private var peopleModel: PeopleModel? {
        didSet {
            self.isFavorite(peopleModel!) { self.output.isFavorite.accept($0) }
        }
    }
    weak var coordinator: Coordinator?
    private let disposeBag = DisposeBag()
    
    
    //    MARK: - Input
    
    struct Input {
        let selectedItem = PublishRelay<CreditInMediaViewModel>()
        let toggleFavoriteStatus = PublishRelay<Void>()
    }
    let input = Input()
    
    //    MARK: - Output
    
    struct Output {
        let name = BehaviorRelay<String>(value: "")
        let sectionedItems = BehaviorRelay<[PeopleDetailCellViewModelMultipleSection]>(value: [])
        let isFavorite = PublishRelay<Bool>()
    }
    
    let output = Output()
    
    
//    MARK: - Init
    required init(with peopleID: String,
                  useCaseProvider: Domain.UseCaseProvider,
                  useCasePersistenceProvider: Domain.UseCasePersistenceProvider,
                  networkMonitor: Domain.NetworkMonitor) {
        self.useCaseProvider = useCaseProvider
        self.useCasePersistenceProvider = useCasePersistenceProvider
        self.networkMonitor = networkMonitor
        
        self.peopleID = peopleID
        
        setupInput()
        setupOutput()
    }
    
//    MARK: - Methods
    
    fileprivate func setupInput() {
        input.selectedItem.subscribe(onNext: {
            guard let coordinator = self.coordinator as? PeopleFlowCoordinator else { return }
            switch $0.mediaType {
            case .movie: coordinator.toMovieDetail(with: $0.id)
            case .tv: coordinator.toTVDetail(with: $0.id)
            default: break
            }
        }).disposed(by: disposeBag)
        
        input.toggleFavoriteStatus.subscribe(onNext: { [weak self] in
            self?.toggleFavoriteStatus()
        }).disposed(by: disposeBag)
    }
    
    private func toggleFavoriteStatus() {
        let useCase = useCasePersistenceProvider.makeFavoritePeopleUseCase()
        guard let peopleModel = peopleModel else { return }
        useCase.toggleFavoriteStatus(peopleModel) { [weak self] (isFavorite) in
            self?.output.isFavorite.accept(isFavorite)
        }
    }
    
    private func refreshFavoriteStatus() {
        guard let peopleModel = peopleModel else { return }
        isFavorite(peopleModel) { [weak self] (isFavorite) in
            self?.output.isFavorite.accept(isFavorite)
        }
    }
    
    private func isFavorite(_ model: PeopleModel, _ completion: @escaping (Bool) -> Void) {
        let useCase = useCasePersistenceProvider.makeFavoritePeopleUseCase()
        useCase.isFavorite(model) { completion($0) }

    }
    
    fileprivate func setupOutput() {
        self.fetch { [weak self] (peopleDetail) in
            guard let self = self else { return }
            
            self.peopleModel = PeopleModel(peopleDetail)
            let sections = self.configureSections(from: peopleDetail)
            self.output.name.accept(peopleDetail.name)
            self.output.sectionedItems.accept(sections)
        }
    }
    
    fileprivate func fetch(completion: @escaping (PeopleDetailModel) -> Void) {
        
        let useCase = useCaseProvider.makePeopleDetailUseCase()
        useCase.details(personID: peopleID, appendToResponse: [.combinedCredits, .images], includeImageLanguage: [.ru, .null]) { [weak self] (result: Result<PeopleDetailModel, Error>) in
            switch result {
            case .success(let peopleDetail):
                completion(peopleDetail)
                
            case .failure(let error):
                self?.inform(with: error.localizedDescription)
            }
        }
    }
    
    fileprivate func configureSections(from model: PeopleDetailModel) -> [PeopleDetailCellViewModelMultipleSection] {
        
        let sections = [PeopleDetailCellViewModelMultipleSection]()
        
        return sections
            .buildSection(withModel: model, andAction: configureProfileWrapperSection(with:sections:))
            .buildSection(withModel: model, andAction: configureImageListSection(withModel:sections:))
            .buildSection(withModel: model, andAction: configureBioSection(with:sections:))
            .buildSection(withModel: model, andAction: configureBestMediaSection(with:sections:))
            .buildSection(withModel: model, andAction: configureCastSection(with:sections:))
            .buildSection(withModel: model, andAction: configureCrewSection(with:sections:))

    }
    
    fileprivate func configureProfileWrapperSection(with model: PeopleDetailModel, sections: [PeopleDetailCellViewModelMultipleSection]) -> [PeopleDetailCellViewModelMultipleSection] {
        let title = ""
        var sections = sections
        
        let profileWrapperSection: PeopleDetailCellViewModelMultipleSection = .profileWrapperSection(title: title, items: [.profileWrapper(vm: PeopleProfileWrapperCellViewModel(model))])
        
        sections.append(profileWrapperSection)
        return sections
    }
    
    fileprivate func configureImageListSection(withModel model: PeopleDetailModel, sections: [PeopleDetailCellViewModelMultipleSection]) -> [PeopleDetailCellViewModelMultipleSection] {
        let title = "Фото"
        guard var images = model.images?.profiles, !images.isEmpty else { return sections }
        images.removeFirst()
        guard !images.isEmpty else { return sections }
        var sections = sections
        
        guard let coordinator = coordinator as? ToImageFullScreenRoutable else { return sections }
        
        let items: [PeopleDetailCellViewModelMultipleSection.SectionItem] = [.imageList(vm: ImageListViewModel(title: title, items: images.map { ImageCellViewModel($0, imageType: .profile(size: .small)) }, coordinator: coordinator, contentForm: .portrait))]
        
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
        
        var credits = [Int: [String]]()
        
        cast.forEach { (castModel) in
            guard let character = castModel.character else { return }
            if credits.index(forKey: castModel.id) != nil {
                credits[castModel.id]!.append(character)
            } else {
                credits[castModel.id] = [character]
            }
        }
        
        crew.forEach { (crewModel) in
            if credits.index(forKey: crewModel.id) != nil {
                credits[crewModel.id]!.append(crewModel.job)
            } else {
                credits[crewModel.id] = [crewModel.job]
            }
        }

        let groupedCredit =
            cast.filter { $0.character != nil }.map {
                GroupedCreditInMediaModel(
                    id: $0.id,
                    posterPath: $0.posterPath,
                    mediaTitle: ($0.mediaType == .movie) ? $0.title! : $0.name!,
                    mediaType: $0.mediaType,
                    credit: credits[$0.id]!.joined(separator: ", "),
                    voteAverage: $0.voteAverage,
                    releaseDate: ($0.mediaType == .movie) ? $0.releaseDate : "",
                    firstAirDate: ($0.mediaType == .tv) ? $0.firstAirDate : ""
                    )
                
            } +
            crew.map {
                GroupedCreditInMediaModel(
                    id: $0.id,
                    posterPath: $0.posterPath,
                    mediaTitle: ($0.mediaType == .movie) ? $0.title! : $0.name!,
                    mediaType: $0.mediaType,
                    credit: credits[$0.id]!.joined(separator: ", "),
                    voteAverage: $0.voteAverage,
                    releaseDate: ($0.mediaType == .movie) ? $0.releaseDate : "",
                    firstAirDate: ($0.mediaType == .tv) ? $0.firstAirDate : ""
                    )
                
            }
        
        let creditInMovie: [CreditInMediaCellViewModelMultipleSection.SectionItem] = groupedCredit.filter { $0.mediaType.rawValue == MediaType.movie.rawValue }.toUnique().sorted(by: >).prefix(5).map { .creditInMovie(vm: CreditInMediaViewModel($0)) }
        
        let creditInTV: [CreditInMediaCellViewModelMultipleSection.SectionItem] = groupedCredit.filter { $0.mediaType.rawValue == MediaType.tv.rawValue }.toUnique().sorted(by: >).prefix(5).map { .creditInTV(vm: CreditInMediaViewModel($0)) }
        
        let movieSectionItems: [CreditInMediaCellViewModelMultipleSection.SectionItem] = creditInMovie.sorted(by: >)
        let tvSectionItems: [CreditInMediaCellViewModelMultipleSection.SectionItem] = creditInTV.sorted(by: >)
        
        let bestMediaSection: PeopleDetailCellViewModelMultipleSection = .bestMediaSection(
            title: title,
            items:
                [
                    PeopleDetailCellViewModelMultipleSection.SectionItem.bestMedia(vm: PeopleBestMediaListViewModel(title: title, items: movieSectionItems + tvSectionItems, coordinator: coordinator))
                ]
        )
        
        if (!bestMediaSection.items.isEmpty) { sections.append(bestMediaSection) }
        return sections
    }
    
    fileprivate func configureCastSection(with model: PeopleDetailModel, sections: [PeopleDetailCellViewModelMultipleSection]) -> [PeopleDetailCellViewModelMultipleSection] {
        let title = "Актер"
        var sections = sections
        
        guard let cast = model.combinedCredits?.cast, !cast.isEmpty else { return sections }
        
        var credits = [Int: [String]]()
        
        cast.forEach { (castModel) in
            guard let character = castModel.character else { return }
            if credits.index(forKey: castModel.id) != nil {
                credits[castModel.id]!.append(character)
            } else {
                credits[castModel.id] = [character]
            }
        }
        
        let groupedCastItems: [PeopleDetailCellViewModelMultipleSection.SectionItem] =
            cast.filter { $0.character != nil }.map {
                GroupedCreditInMediaModel(
                    id: $0.id,
                    posterPath: $0.posterPath,
                    mediaTitle: ($0.mediaType == .movie) ? $0.title! : $0.name!,
                    mediaType: $0.mediaType,
                    credit: credits[$0.id]!.joined(separator: ", "),
                    voteAverage: $0.voteAverage,
                    releaseDate: ($0.mediaType == .movie) ? $0.releaseDate : "",
                    firstAirDate: ($0.mediaType == .tv) ? $0.firstAirDate : ""
                    )
                
            }.toUnique().sorted(by: >).map { PeopleDetailCellViewModelMultipleSection.SectionItem.cast(vm: CreditInMediaViewModel($0)) }
        
        let castSection: PeopleDetailCellViewModelMultipleSection = .castSection(title: title, items: groupedCastItems)
        
        if !castSection.items.isEmpty { sections.append(castSection) }
        return sections
    
    
    }
    
    fileprivate func configureCrewSection(with model: PeopleDetailModel, sections: [PeopleDetailCellViewModelMultipleSection]) -> [PeopleDetailCellViewModelMultipleSection] {
        let title = "Создатель"
        var sections = sections
        
        guard let crew = model.combinedCredits?.crew, !crew.isEmpty else { return sections }
        
        var credits = [Int: [String]]()
        
        crew.forEach { (crewModel) in
            if credits.index(forKey: crewModel.id) != nil {
                credits[crewModel.id]!.append(crewModel.job)
            } else {
                credits[crewModel.id] = [crewModel.job]
            }
        }
        
        let groupedCrewItems: [PeopleDetailCellViewModelMultipleSection.SectionItem] =
            crew.map {
                GroupedCreditInMediaModel(
                    id: $0.id,
                    posterPath: $0.posterPath,
                    mediaTitle: ($0.mediaType == .movie) ? $0.title! : $0.name!,
                    mediaType: $0.mediaType,
                    credit: credits[$0.id]!.joined(separator: ", "),
                    voteAverage: $0.voteAverage,
                    releaseDate: ($0.mediaType == .movie) ? $0.releaseDate : "",
                    firstAirDate: ($0.mediaType == .tv) ? $0.firstAirDate : ""
                    )
                
            }.toUnique().sorted(by: >).map { PeopleDetailCellViewModelMultipleSection.SectionItem.crew(vm: CreditInMediaViewModel($0)) }
        
        let crewSection: PeopleDetailCellViewModelMultipleSection = .crewSection(title: title, items: groupedCrewItems)
        
        if !crewSection.items.isEmpty { sections.append(crewSection) }
        return sections
    }
    
    private func inform(with message: String) {
        networkMonitor.delegate?.inform(with: message)
    }
}
