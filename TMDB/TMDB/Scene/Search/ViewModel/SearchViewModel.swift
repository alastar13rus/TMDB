//
//  SearchViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 25.05.2021.
//

import Foundation
import Domain
import RxSwift
import RxRelay


class SearchViewModel {
    
    typealias Section = SearchQuickRequestCellModelMultipleSection
    typealias Item = Section.SectionItem

//    MARK: - Properties
    let useCaseProvider: UseCaseProvider
    weak var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    private var state = State()
    
    struct Input {
        let query = BehaviorRelay<String>(value: "")
        let refreshTrigger = PublishRelay<Void>()
        let loadNextPageTrigger = PublishRelay<Void>()
        let removeResultListTrigger = PublishRelay<Void>()
        let selectedItem = PublishRelay<Item>()
    }
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let sectionedItems = BehaviorRelay<[Section]>(value: [])
        let isFetching = BehaviorRelay<Bool>(value: false)
    }
    
    private struct State {
        var currentPage = 1
        var numberOfMedia = 0
        var setOfFetchedMediaList = Set<Int>()
    }
    
//    MARK: - Init
    init(useCaseProvider: UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        
        subscribing()
        setupOutput()
    }
    
//    MARK: - Methods
    fileprivate func subscribing() {
        input.query.skip(1).subscribe(onNext: { [weak self] (query) in
            guard let self = self else { return }
            
            self.state.currentPage = 1
            self.state.setOfFetchedMediaList.removeAll()
            self.fetchResults(query, page: self.state.currentPage) { [weak self] (result) in
                guard let self = self else { return }

                let foundMediaItems = self.handleResults(result)
                self.reloadSectionedItemsAfterFetchingResults(with: foundMediaItems, currentSections: self.output.sectionedItems.value)
            }
        }).disposed(by: disposeBag)
        
        input.selectedItem.subscribe(onNext: { [weak self] (item) in
            
            switch item {
            case .people(let vm):
                guard let self = self, let coordinator = self.coordinator as? ToPeopleRoutable else { return }
                coordinator.toPeople(with: vm.id)
            case .media(let vm):
                guard let self = self, let coordinator = self.coordinator as? SearchFlowCoordinator else { return }
                switch vm.mediaType {
                case .movie: coordinator.toMovie(with: vm.id)
                case .tv: coordinator.toTV(with: vm.id)
                default: return
                }
                default: return
            }
        }).disposed(by: disposeBag)
        
        input.loadNextPageTrigger.subscribe(onNext: { [ weak self] in
            guard let self = self else { return }
            
            self.state.currentPage += 1
            self.fetchResults(self.input.query.value, page: self.state.currentPage) { [ weak self] (result) in
                
                guard let self = self else { return }
                let fetchedItems = self.handleResults(result)
                let currentItems = self.output.sectionedItems.value
                    .filter { if case .resultSection = $0 { return true } else { return false } }
                    .flatMap { section -> [Item] in
                    return section.items + fetchedItems
                }
                let otherSections: [Section] = self.output.sectionedItems.value
                    .filter { if case .resultSection = $0 { return false } else { return true } }
                let resultSection: Section = .resultSection(title: "Результаты поиска", items: currentItems)
                
                self.output.sectionedItems.accept([resultSection] + otherSections)
                self.state.numberOfMedia = currentItems.count
                
            }
        }).disposed(by: disposeBag)
        
        input.removeResultListTrigger.subscribe(onNext: { [ weak self] in
            guard let self = self else { return }
            
            self.state.currentPage = 1
            self.state.numberOfMedia = 0
            self.removeResultSection()
            
        }).disposed(by: disposeBag)
    }
    
    fileprivate func reloadSectionedItemsAfterFetchingResults(with foundMediaItems: [Item], currentSections: [Section]) {
        var newSections = currentSections
        let resultSectionIndex = newSections.firstIndex {
            if case .resultSection = $0 { return true } else { return false }
        }
        if let index = resultSectionIndex {
            newSections[index] = .resultSection(title: "Результаты поиска", items: foundMediaItems)
        } else {
            newSections.insert(.resultSection(title: "Результаты поиска", items: foundMediaItems), at: 0)
        }
        output.sectionedItems.accept(newSections)
    }
    
    fileprivate func removeResultSection() {
        let currentSections = self.output.sectionedItems.value
        let newSections = currentSections.compactMap { (section) -> Section? in
            guard case .resultSection = section else { return section }
            return nil
        }
        self.output.sectionedItems.accept(newSections)
    }
    
    fileprivate func setupOutput() {
        
        
        var sections: [SearchQuickRequestCellModelMultipleSection] = []
        
        setupPeopleShortListSection { [weak self] in
            sections.append($0)
            self?.output.sectionedItems.accept(sections)
        }
        
        setupCategoryListSection { [weak self] in
            sections.append($0)
            self?.output.sectionedItems.accept(sections)
        }
        
        
    }
    
    fileprivate func fetchPopularPeoples(_ completion: @escaping ([Domain.PeopleModel]) -> Void) {
        let useCase = useCaseProvider.makePeopleListUseCase()
        useCase.popular { (result) in
            if case .success(let peopleListResponse) = result {
                let peoples = peopleListResponse.results
                completion(peoples)
            }
        }
    }
    
    fileprivate func setupPeopleShortListSection(_ completion: @escaping (Section) -> Void) {
        fetchPopularPeoples { (peoples) in
            let title = "Популярные люди"
            let peopleShortListViewModel =
                PeopleShortListViewModel(title: title,
                                         items: peoples.map { PeopleCellViewModel($0) },
                                         delegate: self)
            let item = Item.peopleList(vm: peopleShortListViewModel)
            let section = Section.peopleListSection(title: title, items: [item])
            completion(section)
        }
    }
    
    fileprivate func fetchSearchQuickCategories(_ completion: @escaping ([SearchCategory]) -> Void) {
        let useCase = useCaseProvider.makeSearchUseCase()
        useCase.searchQuickCategories { completion($0) }
    }
    
    fileprivate func setupCategoryListSection(_ completion: @escaping (Section) -> Void) {
        fetchSearchQuickCategories { (categories) in
            let title = "Категории"
            let searchCategoryListViewModel = SearchCategoryListViewModel(title: title, items: categories.map { SearchCategoryCellViewModel($0) }, delegate: self)
            let item = Item.categoryList(vm: searchCategoryListViewModel)
            let section = Section.categoryListSection(title: title, items: [item])
            completion(section)
        }
    }
    
    fileprivate func fetchResults(_ query: String, page: Int, completion: @escaping (Result<MultiSearchResponse, Error>) -> Void) {
        let useCase = useCaseProvider.makeSearchUseCase()
        useCase.multiSearch(query, page: page) { completion($0) }
    }
    
    fileprivate func handleResults(_ result: Result<MultiSearchResponse, Error>) -> [Item] {
        
        guard case .success(let response) = result else { return [] }
        
        let items = response.results.filter { !setOfFetchedMediaListIsContainsMediaItem($0) }.map { (searchItem) -> Item in
            switch searchItem {
            case .movie(let movieModel): return .media(vm: MediaCellViewModel(movieModel))
            case .tv(let tvModel): return .media(vm: MediaCellViewModel(tvModel))
            case .person(let peopleModel): return .people(vm: PeopleCellViewModel(peopleModel))
            }
        }
        
        state.setOfFetchedMediaList = refreshSetOfFetchedMediaList(items: items)
        return items
    }
    
    fileprivate func refreshSetOfFetchedMediaList(items: [Item]) -> Set<Int> {
        let fetchedListOfID = items.compactMap { (item) -> Int? in
            switch item {
            case .media(let vm): return Int(vm.id)
            case .people(let vm): return Int(vm.id)
            default: return nil
            }
        }
        return Set(fetchedListOfID)
    }
    
    fileprivate func setOfFetchedMediaListIsContainsMediaItem(_ mediaItem: SearchMediaItem) -> Bool {
        switch mediaItem {
        case .movie(let movieModel): return state.setOfFetchedMediaList.contains(movieModel.id)
        case .tv(let tvModel): return state.setOfFetchedMediaList.contains(tvModel.id)
        case .person(let peopleModel): return state.setOfFetchedMediaList.contains(peopleModel.id)
        }
    }
    
}

extension SearchViewModel: PeopleShortListViewModelDelegate {
    var peopleShortListDelegateCoordinator: ToPeopleRoutable? {
        coordinator as? ToPeopleRoutable
    }
}

extension SearchViewModel: SearchCategoryListViewModelDelegate {
    weak var searchFlowCoordinator: SearchFlowCoordinator? { coordinator as? SearchFlowCoordinator }
    
    func routing(with type: SearchCategory) {
        guard let coordinator = self.searchFlowCoordinator else { return }
        coordinator.showFilterOptionListMedia(type: type)
    }
}

