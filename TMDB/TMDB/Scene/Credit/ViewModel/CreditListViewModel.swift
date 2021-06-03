//
//  CreditListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import Domain
import NetworkPlatform

class CreditListViewModel {
    
//    MARK: - Properties
    let mediaID: String
    let seasonNumber: String?
    let episodeNumber: String?
    
    var creditType: CreditType {
        didSet {
            switch creditType {
            case .cast, .crew, .guestStars: output.title.accept("Показать еще")
            }
        }
    }
    
    var mediaType: MediaType = .movie
    
    let useCaseProvider: Domain.UseCaseProvider
    
    weak var coordinator: Coordinator? {
        didSet {
            setupOutput()
        }
    }
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let selectedItem = PublishRelay<CreditListViewModelMultipleSection.SectionItem>()
    }
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let sectionedItems = BehaviorRelay<[CreditListViewModelMultipleSection]>(value: [])
    }
    
//    MARK: - Init
    init(with mediaID: String, mediaType: MediaType, creditType: CreditType, seasonNumber: String?, episodeNumber: String?, useCaseProvider: Domain.UseCaseProvider) {
        
        self.useCaseProvider = useCaseProvider
        
        self.mediaID = mediaID
        self.creditType = creditType
        self.mediaType = mediaType
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
        
        subscribing()
    }
    
//    MARK: - Methods
    fileprivate func subscribing() {
        self.input.selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            switch self.coordinator {
            case let coordinator as MovieFlowCoordinator:
                self.routingWithCoordinator(coordinator: coordinator, item: $0)
            case let coordinator as TVFlowCoordinator:
                self.routingWithCoordinator(coordinator: coordinator, item: $0)
            case let coordinator as TVSeasonFlowCoordinator:
                self.routingWithCoordinator(coordinator: coordinator, item: $0)
            case let coordinator as TVEpisodeFlowCoordinator:
                self.routingWithCoordinator(coordinator: coordinator, item: $0)
            default: break
            }
            
        }).disposed(by: disposeBag)
    }
    
    fileprivate func routingWithCoordinator<T: ToPeopleRoutable>(coordinator: T, item: CreditListViewModelMultipleSection.SectionItem) {
        switch item {
        case .cast(let vm): coordinator.toPeople(with: vm.id)
        case .crew(let vm): coordinator.toPeople(with: vm.id)
        case .tvAggregateCast(let vm): coordinator.toPeople(with: vm.id)
        case .tvAggregateCrew(let vm): coordinator.toPeople(with: vm.id)
        }
    }
    
//    private func fetch<T: CreditListResponseProtocol & Decodable>(completion: @escaping (T) -> Void) {
//        let useCase = useCaseProvider.makeTVDetailUseCase()
//        networkManager.request(api) { (result: Result<T, Error>) in
//            switch result {
//            case .success(let response): completion(response)
//            case .failure: break
//            }
//        }
//    }
    
    private func setupOutput() {
        
        switch mediaType {
        case .movie: fetchMovieCredits()
        case .tv: fetchTVCredits()
        case .tvSeason: fetchTVSeasonCredits()
        case .tvEpisode: fetchTVEpisodeCredits()
        default: break
        }
        
    }
    
    private func fetchMovieCredits() {
        
        let useCase = useCaseProvider.makeMovieDetailUseCase()
        useCase.credits(mediaID: mediaID) { [weak self] (result: Result<CreditListResponse, Error>) in
            guard let self = self else { return }
            
            guard case .success(let response) = result else { return }
            
            switch self.creditType {
            case .cast:
                let title = "Актеры"
                let items: [CreditListViewModelMultipleSection.SectionItem] =
                    response.cast.map { CreditListViewModelMultipleSection.SectionItem.cast(vm: CastCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .castSection(title: title, items: items)
                ])
                
                self.output.title.accept(title)
                
            case .crew:
                let title = "Съемочная группа"
                var jobs = [Int: [String]]()
                
                response.crew.forEach { (crewModel) in
                    if jobs.index(forKey: crewModel.id) != nil {
                        jobs[crewModel.id]!.append(crewModel.job)
                    } else {
                        jobs[crewModel.id] = [crewModel.job]
                    }
                }
                
                let items = response.crew
                    .map {
                        GroupedCrewModel(adult: $0.adult, gender: $0.gender, id: $0.id, knownForDepartment: $0.knownForDepartment, name: $0.name, originalName: $0.originalName, popularity: $0.popularity, profilePath: $0.profilePath, creditID: $0.creditID, jobs: jobs[$0.id]!.joined(separator: ", "))
                    }
                    .toUnique()
                    .sorted(by: >)
                    .map { CreditListViewModelMultipleSection.SectionItem.crew(vm: CrewCombinedCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .crewSection(title: title, items: items)
                ])
                
                self.output.title.accept(title)
                
            default: break
            }
        }
    }
    
    private func fetchTVCredits() {
        
        let useCase = useCaseProvider.makeTVDetailUseCase()
        useCase.aggregateCredits(mediaID: mediaID) { [weak self] (result: Result<TVAggregateCreditListResponse, Error>) in
            guard let self = self else { return }
            
            guard case .success(let response) = result else { return }
            
            switch self.creditType {
            case .cast:
                let title = "Актеры"
                let items: [CreditListViewModelMultipleSection.SectionItem] =
                    response.cast.map { CreditListViewModelMultipleSection.SectionItem.tvAggregateCast(vm: AggregateCastCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .castSection(title: title, items: items)
                ])
                self.output.title.accept(title)
                
            case .crew:
                let title = "Съемочная группа"
                let items: [CreditListViewModelMultipleSection.SectionItem] =
                    response.crew.sorted(by: >).map { CreditListViewModelMultipleSection.SectionItem.tvAggregateCrew(vm: AggregateCrewCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .crewSection(title: title, items: items)
                ])
                self.output.title.accept(title)
                
            default: break
            }
        }
    }
    
    private func fetchTVSeasonCredits() {
        
        guard let seasonNumber = seasonNumber else { return }
        
        let useCase = useCaseProvider.makeTVSeasonDetailUseCase()
        useCase.aggregateCredits(mediaID: mediaID, seasonNumber: seasonNumber) { [weak self] (result: Result<TVAggregateCreditListResponse, Error>) in
            guard let self = self else { return }
            
            guard case .success(let response) = result else { return }
            
            switch self.creditType {
            case .cast:
                let title = "Актеры"
                let items: [CreditListViewModelMultipleSection.SectionItem] =
                    response.cast.map { CreditListViewModelMultipleSection.SectionItem.tvAggregateCast(vm: AggregateCastCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .castSection(title: title, items: items)
                ])
                self.output.title.accept(title)
                
            case .crew:
                let title = "Съемочная группа"
                let items: [CreditListViewModelMultipleSection.SectionItem] =
                    response.crew.sorted(by: >).map { CreditListViewModelMultipleSection.SectionItem.tvAggregateCrew(vm: AggregateCrewCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .crewSection(title: title, items: items)
                ])
                self.output.title.accept(title)
                
            default: break
            }
            
        }
    }
    
    private func fetchTVEpisodeCredits() {
    
        guard let seasonNumber = seasonNumber, let episodeNumber = episodeNumber else { return }
        let useCase = useCaseProvider.makeTVEpisodeDetailUseCase()
        
        useCase.credits(mediaID: mediaID, seasonNumber: seasonNumber, episodeNumber: episodeNumber) { [weak self] (result: Result<EpisodeCreditList, Error>) in
            guard let self = self else { return }
            
            guard case .success(let response) = result else { return }
            
            switch self.creditType {
            case .cast:
                let title = "Актеры"
                let items: [CreditListViewModelMultipleSection.SectionItem] =
                    response.cast.map { CreditListViewModelMultipleSection.SectionItem.cast(vm: CastCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .castSection(title: title, items: items)
                ])
                self.output.title.accept(title)
                
            case .guestStars:
                let title = "Приглашенные звезды"
                let items: [CreditListViewModelMultipleSection.SectionItem] =
                    response.guestStars.map { CreditListViewModelMultipleSection.SectionItem.cast(vm: CastCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .castSection(title: title, items: items)
                ])
                self.output.title.accept(title)
                
            case .crew:
                let title = "Съемочная группа"
                
                var jobs = [Int: [String]]()
                
                response.crew.forEach { (crewModel) in
                    if jobs.index(forKey: crewModel.id) != nil {
                        jobs[crewModel.id]!.append(crewModel.job)
                    } else {
                        jobs[crewModel.id] = [crewModel.job]
                    }
                }
                
                let items = response.crew
                    .map {
                        GroupedCrewModel(adult: $0.adult, gender: $0.gender, id: $0.id, knownForDepartment: $0.knownForDepartment, name: $0.name, originalName: $0.originalName, popularity: $0.popularity, profilePath: $0.profilePath, creditID: $0.creditID, jobs: jobs[$0.id]!.joined(separator: ", "))
                    }
                    .toUnique()
                    .sorted(by: >)
                    .map { CreditListViewModelMultipleSection.SectionItem.crew(vm: CrewCombinedCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .crewSection(title: title, items: items)
                ])
                self.output.title.accept(title)
            }
        }
    }
    
}
