//
//  CreditListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 15.04.2021.
//

import Foundation
import RxSwift
import RxRelay

enum CreditType: String {
    case cast
    case crew
}

class CreditListViewModel: DetailWithParamViewModelType {
    
//    MARK: - Properties
    let detailID: String
    var api: TmdbAPI {
        switch params[String(describing: Coordinator.self)] {
        case String(describing: TVListCoordinator.self):
            return TmdbAPI.tv(.credits(mediaID: detailID))
        default:
            return TmdbAPI.movies(.credits(mediaID: detailID))
        }
    }
    var params: [String: String]
    
    var creditType: CreditType {
        didSet {
            switch creditType {
            case .cast: output.title.accept("Показать еще")
            case .crew: output.title.accept("Показать еще")
            }
        }
    }
    
    let networkManager: NetworkManagerProtocol
    weak var coordinator: Coordinator?
    
    let input = Input()
    let output = Output()
    
    struct Input {
        
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
        
        self.networkManager = networkManager
        
        setupOutput()
    }
    
//    MARK: - Methods
    private func fetch(completion: @escaping (CreditListResponse) -> Void) {
        networkManager.request(api) { (result: Result<CreditListResponse, Error>) in
            switch result {
            case .success(let response): completion(response)
            case .failure: break
            }
        }
    }
    
    private func setupOutput() {
        
        fetch { [weak self] (response) in
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
                let title = "Создатели"
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
                        CrewCombinedModel(adult: $0.adult, gender: $0.gender, id: $0.id, knownForDepartment: $0.knownForDepartment, name: $0.name, originalName: $0.originalName, popularity: $0.popularity, profilePath: $0.profilePath, creditID: $0.creditID, jobs: (jobs[$0.id]?.joined(separator: ", "))!)
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
