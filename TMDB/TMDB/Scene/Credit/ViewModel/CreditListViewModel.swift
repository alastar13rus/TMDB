//
//  CreditListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import Foundation
import RxSwift
import RxRelay

class CreditListViewModel: DetailWithParamViewModelType {
    
//    MARK: - Properties
    let detailID: String
    var api: TmdbAPI {
        switch params[String(describing: Coordinator.self)] {
        case String(describing: TVListCoordinator.self):
            return TmdbAPI.tv(.aggregateCredits(mediaID: detailID))
        default:
            return TmdbAPI.movies(.credits(mediaID: detailID))
        }
    }
    
    var params: [String: String]
    
    var creditType: CreditType {
        didSet {
            switch creditType {
            case .cast, .crew: output.title.accept("Показать еще")
            }
        }
    }
    
    var mediaType: MediaType = .movie
    
    let networkManager: NetworkManagerProtocol
    weak var coordinator: Coordinator?
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
    required init(with detailID: String, networkManager: NetworkManagerProtocol, params: [String:String]) {
        self.detailID = detailID
        self.params = params
        
        if let rawValue = params[String(describing: CreditType.self)],
           let creditType = CreditType(rawValue: rawValue) {
            self.creditType = creditType
        } else {
            self.creditType = .cast
        }
        
        if let rawValue = params[String(describing: MediaType.self)],
           let mediaType = MediaType(rawValue: rawValue) {
            self.mediaType = mediaType
        } else {
            self.mediaType = .movie
        }
        
        self.networkManager = networkManager
        
        setupOutput()
        subscribing()
    }
    
//    MARK: - Methods
    fileprivate func subscribing() {
        self.input.selectedItem.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            switch self.coordinator {
            case let coordinator as MovieListCoordinator:
                self.routingWithMovieCoordinator(coordinator: coordinator, item: $0)
            case let coordinator as TVListCoordinator:
                self.routingWithTVCoordinator(coordinator: coordinator, item: $0)
            default: break
            }
            
        }).disposed(by: disposeBag)
    }
    
    fileprivate func routingWithMovieCoordinator(coordinator: MovieListCoordinator, item: CreditListViewModelMultipleSection.SectionItem) {
        switch item {
        case .cast(let vm): coordinator.toPeople(with: vm.id)
        case .crew(let vm): coordinator.toPeople(with: vm.id)
        case .tvAggregateCast(let vm): coordinator.toPeople(with: vm.id)
        case .tvAggregateCrew(let vm): coordinator.toPeople(with: vm.id)
        }
    }
    
    fileprivate func routingWithTVCoordinator(coordinator: TVListCoordinator, item: CreditListViewModelMultipleSection.SectionItem) {
        switch item {
        case .cast(let vm): coordinator.toPeople(with: vm.id)
        case .crew(let vm): coordinator.toPeople(with: vm.id)
        case .tvAggregateCast(let vm): coordinator.toPeople(with: vm.id)
        case .tvAggregateCrew(let vm): coordinator.toPeople(with: vm.id)
            
        }
    }
    
//    fileprivate func fetchPeopleID(with creditID: String, completion: @escaping (String) -> Void) {
//            networkManager.request(TmdbAPI.credit(.details(creditID: creditID)), completion: { (result: Result<CreditDetailModel, Error>) in
//                switch result {
//                case .success(let creditDetail):
//                    let peopleID = "\(creditDetail.person.id)"
//                    completion(peopleID)
//                case .failure: break
//                }
//            })
//    }
    
    private func fetch<T: CreditListResponseProtocol & Decodable>(completion: @escaping (T) -> Void) {
        networkManager.request(api) { (result: Result<T, Error>) in
            switch result {
            case .success(let response): completion(response)
            case .failure: break
            }
        }
    }
    
    private func setupOutput() {
        
        switch mediaType {
        case .movie:
            fetch { [weak self] (response: CreditListResponse) in
                guard let self = self else { return }
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
                }
            }
        case .tv:
            fetch { [weak self] (response: TVAggregateCreditListResponse) in
                guard let self = self else { return }
                switch self.creditType {
                case .cast:
                        let title = "Актеры"
                        let items: [CreditListViewModelMultipleSection.SectionItem] =
                            response.cast.map { CreditListViewModelMultipleSection.SectionItem.tvAggregateCast(vm: TVAggregateCastCellViewModel($0)) }
                        self.output.sectionedItems.accept([
                            .castSection(title: title, items: items)
                        ])
                        self.output.title.accept(title)
                    
                case .crew:
                    let title = "Съемочная группа"
                let items: [CreditListViewModelMultipleSection.SectionItem] =
                    response.crew.sorted(by: >).map { CreditListViewModelMultipleSection.SectionItem.tvAggregateCrew(vm: TVAggregateCrewCellViewModel($0)) }
                self.output.sectionedItems.accept([
                    .crewSection(title: title, items: items)
                ])
                self.output.title.accept(title)
                }
            }
        }
        
    }
        
        
        
        
    
    
}
