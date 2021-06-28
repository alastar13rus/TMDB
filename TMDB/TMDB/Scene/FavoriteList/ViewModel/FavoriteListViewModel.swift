//
//  FavoriteListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 07.06.2021.
//

import Foundation
import RxSwift
import RxRelay
import Domain

class FavoriteListViewModel {
    
    typealias Section = FavoriteCellViewModelMultipleSection
    typealias Item = Section.SectionItem
    
//    MARK: - Properties
    let useCasePersistenceProvider: Domain.UseCasePersistenceProvider

    private let disposeBag = DisposeBag()
    weak var coordinator: NavigationCoordinator?
    
//    MARK: - Input
    let input = Input()
    
    struct Input {
        let selectedItem = PublishRelay<Item>()
        let deletedItem = PublishRelay<Item>()
        let viewWillAppear = PublishRelay<Void>()
    }
    
    
//    MARK: - Output
    let output = Output()
    
    struct Output {
        let sectionedItems = BehaviorRelay<[Section]>(value: [])
        let title = BehaviorRelay<String>(value: "Избранное")
    }
    
    
    
//    MARK: - Init
    init(useCaseProvider: UseCaseProvider, useCasePersistenceProvider: Domain.UseCasePersistenceProvider) {
        self.useCasePersistenceProvider = useCasePersistenceProvider

        setupInput()
        setupOutput()
    }
    
//    MARK: - Methods
    private func setupInput() {
        
        input.selectedItem.subscribe(onNext: { [weak self] in
            self?.handleRoute(with: $0)
        }).disposed(by: disposeBag)
        
        input.deletedItem.subscribe(onNext: { [weak self] in
            self?.deleteFromFavoriteList($0) { [weak self] _ in
                self?.setupSections()
            }
        }).disposed(by: disposeBag)
        
        input.viewWillAppear.subscribe(onNext: { [weak self] in
            self?.setupOutput()
        }).disposed(by: disposeBag)
    }
    
    private func handleRoute(with item: Item) {
        guard let coordinator = self.coordinator as? FavoriteFlowCoordinator else { return }
        switch item {
        case .media(let vm):
            if case .movie = vm.mediaType { coordinator.toMovie(with: vm.id) }
            if case .tv = vm.mediaType { coordinator.toTV(with: vm.id) }
        case .people(let vm):
            coordinator.toPeople(with: vm.id)
        }
    }
    
    private func deleteFromFavoriteList(_ item: Item, _ completion: @escaping (Bool) -> Void) {
        switch item {
        case .media(let vm):
            
            if case .movie = vm.mediaType {
                let useCase = useCasePersistenceProvider.makeFavoriteMovieUseCase()
                guard let movieID = Int(vm.id) else { return }
                useCase.removeFavoriteMovie(movieID) { completion($0) }
            }
            
            if case .tv = vm.mediaType {
                let useCase = useCasePersistenceProvider.makeFavoriteTVUseCase()
                guard let tvID = Int(vm.id) else { return }
                useCase.removeFavoriteTV(tvID) { completion($0) }
            }
            
        case .people(let vm):
            let useCase = useCasePersistenceProvider.makeFavoritePeopleUseCase()
            guard let peopleID = Int(vm.id) else { return }
            useCase.removeFavoritePeople(peopleID) { completion($0) }
        }
    }
    
    private func setupOutput() {
        setupSections()
    }
    
    private func setupSections() {
        let group = DispatchGroup()
        
        var movieSection: Section?
        var tvSection: Section?
        var peopleSection: Section?
        
        group.enter()
        setupMovieSection {
            movieSection = $0
            group.leave()
        }
        
        group.enter()
        setupTVSection {
            tvSection = $0
            group.leave()
        }
        
        group.enter()
        setupPeopleSection {
            peopleSection = $0
            group.leave()
        }
        
        group.notify(queue: .main) { [self] in
            guard 
                  let movieSection = movieSection,
                  let tvSection = tvSection,
                  let peopleSection = peopleSection else { return }
            
            var sections = [Section]()
            if !movieSection.items.isEmpty { sections.append(movieSection) }
            if !tvSection.items.isEmpty { sections.append(tvSection) }
            if !peopleSection.items.isEmpty { sections.append(peopleSection) }
            
            self.output.sectionedItems.accept(sections)
        }
    }
    
    private func setupMovieSection(_ completion: @escaping (Section) -> Void) {
        fetchFavoriteMovieList { (movieList) in
            let title = "Избранные фильмы"
            let items = movieList.map { Item.media(vm: MediaCellViewModel($0)) }
            let section = Section.mediaSection(title: title, items: items)
            completion(section)
        }
    }
        
    private func setupTVSection(_ completion: @escaping (Section) -> Void) {
        fetchFavoriteTVList { (tvList) in
            let title = "Избранные сериалы"
            let items = tvList.map { Item.media(vm: MediaCellViewModel($0)) }
            let section = Section.mediaSection(title: title, items: items)
            completion(section)
        }
    }
    
    private func setupPeopleSection(_ completion: @escaping (Section) -> Void) {
        fetchFavoritePeopleList { (peopleList) in
            let title = "Избранные люди"
            let items = peopleList.map { Item.people(vm: PeopleCellViewModel($0)) }
            let section = Section.peopleSection(title: title, items: items)
            completion(section)
        }
    }
    
    private func fetchFavoriteMovieList(_ completion: @escaping ([MovieModel]) -> Void) {
        let useCase = useCasePersistenceProvider.makeFavoriteMovieUseCase()
        useCase.readFavoriteMovieList { completion($0) }
    }
    
    private func fetchFavoriteTVList(_ completion: @escaping ([TVModel]) -> Void) {
        let useCase = useCasePersistenceProvider.makeFavoriteTVUseCase()
        useCase.readFavoriteTVList { completion($0) }

    }
    
    private func fetchFavoritePeopleList(_ completion: @escaping ([PeopleModel]) -> Void) {
        let useCase = useCasePersistenceProvider.makeFavoritePeopleUseCase()
        useCase.readFavoritePeopleList { completion($0) }

    }
    
}
