//
//  MediaFilteredListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 30.05.2021.
//

import Foundation
import Domain
import RxSwift
import RxRelay

class MediaFilteredListViewModel {
    
    typealias Section = MediaCellViewModelMultipleSection
    typealias Item = Section.SectionItem

// MARK: - Properties
    private let useCaseProvider: Domain.UseCaseProvider
    private let networkMonitor: Domain.NetworkMonitor
    
    let mediaType: Domain.MediaType
    let mediaFilterType: Domain.MediaFilterType
    
    weak var coordinator: NavigationCoordinator?
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    private var state = State()
    
    struct Input {
        let refreshItemsTrigger = PublishRelay<Void>()
        let addItemsTrigger = PublishRelay<Void>()
        let selectedItem = PublishRelay<Item>()
    }
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let sectionedItems = BehaviorRelay<[Section]>(value: [])
        let isFetching = BehaviorRelay<Bool>(value: false)
    }
    
    private struct State {
        var page = 1
        var numberOfMedia = 0
    }
    
// MARK: - Init
    init(mediaType: MediaType,
         mediaFilterType: MediaFilterType,
         useCaseProvider: Domain.UseCaseProvider,
         networkMonitor: Domain.NetworkMonitor) {
        self.mediaType = mediaType
        self.mediaFilterType = mediaFilterType
        self.useCaseProvider = useCaseProvider
        self.networkMonitor = networkMonitor

        setupInput()
        setupOutput()
    }
    
// MARK: - Methods
    fileprivate func setupInput() {
        input.selectedItem.subscribe(onNext: { [weak self] (mediaItem) in
            guard let self = self, let coordinator = self.coordinator as? SearchFlowCoordinator else { return }
            switch mediaItem {
            case .movie(let vm): coordinator.toMovie(with: vm.id)
            case .tv(let vm): coordinator.toTV(with: vm.id)
            }
            
        }).disposed(by: disposeBag)
        
        input.addItemsTrigger.subscribe(onNext: { [ weak self] in
            guard let self = self else { return }
            
            self.state.page += 1
            self.fetch(mediaType: self.mediaType,
                       mediaFilterType: self.mediaFilterType,
                       page: self.state.page) { [ weak self] (mediaList) in
                
                guard let self = self else { return }
                
                switch self.mediaType {
                case .movie:
                    let fetchedItems = mediaList.map { Item.movie(vm: $0) }
                    let currentItems = self.output.sectionedItems.value.flatMap { section -> [Item] in
                        return section.items + fetchedItems }
                    let section: Section = .movieSection(title: "", items: currentItems)
                    self.output.sectionedItems.accept([section])
                    self.state.numberOfMedia = currentItems.count
                case .tv:
                    let fetchedItems = mediaList.map { Item.tv(vm: $0) }
                    let currentItems = self.output.sectionedItems.value.flatMap { section -> [Item] in
                        return section.items + fetchedItems }
                    let section: Section = .tvSection(title: "", items: currentItems)
                    self.output.sectionedItems.accept([section])
                    self.state.numberOfMedia = currentItems.count
                default: break
                }
            }
        }).disposed(by: disposeBag)
        
        input.refreshItemsTrigger.subscribe(onNext: { [ weak self] in
            guard let self = self else { return }
                        
            self.state.page = 1
            self.fetch(mediaType: self.mediaType,
                       mediaFilterType: self.mediaFilterType,
                       page: self.state.page) { [ weak self] (mediaList) in
                
                guard let self = self else { return }
                
                switch self.mediaType {
                case .movie:
                    let fetchedItems = mediaList.map { Item.movie(vm: $0) }
                    let section: Section = .movieSection(title: "", items: fetchedItems)
                    self.output.sectionedItems.accept([section])
                    self.state.numberOfMedia = fetchedItems.count
                case .tv:
                    let fetchedItems = mediaList.map { Item.tv(vm: $0) }
                    let section: Section = .tvSection(title: "", items: fetchedItems)
                    self.output.sectionedItems.accept([section])
                    self.state.numberOfMedia = fetchedItems.count
                default: break
                }
            }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupOutput() {
        
        if case .byGenre(_, let genreName) = mediaFilterType { output.title.accept(genreName) }
        
        if case .byYear(let year) = mediaFilterType {
            switch mediaType {
            case .movie: output.title.accept("Фильмы \(year) года")
            case .tv: output.title.accept("Сериалы \(year) года")
            default: break
            }
        }
        
        fetch(mediaType: mediaType, mediaFilterType: mediaFilterType, page: state.page) { [ weak self] (mediaList) in
            guard let self = self else { return }
            switch self.mediaType {
            case .movie:
                let items = mediaList.map { Item.movie(vm: $0) }
                let section: Section = .movieSection(title: "", items: items)
                self.output.sectionedItems.accept([section])
            case .tv:
                let items = mediaList.map { Item.tv(vm: $0) }
                let section: Section = .tvSection(title: "", items: items)
                self.output.sectionedItems.accept([section])
            default: break
            }
        }
    }
    
    fileprivate func fetch(mediaType: MediaType, mediaFilterType: MediaFilterType, page: Int, completion: @escaping ([MediaCellViewModel]) -> Void) {
        let useCase = useCaseProvider.makeSearchUseCase()
        self.output.isFetching.accept(true)
        
        switch (mediaType, mediaFilterType) {
        case (.movie, .byGenre(let genreID, _)):
            useCase.filterMediaListByGenre(genreID, mediaType:
                                            mediaType, page: page) { [weak self] (result: Result<MediaListResponse<MovieModel>, Error>) in
                guard let self = self else { return }
                completion(self.handleMovie(result))
            }
        case (.movie, .byYear(let year)):
            useCase.filterMediaListByYear(year, mediaType: mediaType,
                                          page: page) { [weak self] (result: Result<MediaListResponse<MovieModel>, Error>) in
                guard let self = self else { return }
                completion(self.handleMovie(result))
            }
        case (.tv, .byGenre(let genreID, _)):
            useCase.filterMediaListByGenre(genreID, mediaType: mediaType,
                                           page: page) { [weak self] (result: Result<MediaListResponse<TVModel>, Error>) in
                guard let self = self else { return }
                completion(self.handleTV(result))
            }
        case (.tv, .byYear(let year)):
            useCase.filterMediaListByYear(year, mediaType: mediaType,
                                          page: page) { [weak self] (result: Result<MediaListResponse<TVModel>, Error>) in
                guard let self = self else { return }
                completion(self.handleTV(result))
            }
        default: break
        }
        self.output.isFetching.accept(false)
    }
    
    fileprivate func handleMovie(_ result: Result<MediaListResponse<MovieModel>, Error>) -> [MediaCellViewModel] {
        switch result {
        case .success(let response):
            return response.results.map { MediaCellViewModel($0) }
        case .failure(let error):
            inform(with: error.localizedDescription)
            return []
        }
    }
    
    fileprivate func handleTV(_ result: Result<MediaListResponse<TVModel>, Error>) -> [MediaCellViewModel] {
        switch result {
        case .success(let response):
            return response.results.map { MediaCellViewModel($0) }
        case .failure(let error):
            inform(with: error.localizedDescription)
            return []
        }
    }
    
    private func inform(with message: String) {
        networkMonitor.alertCoordinator?.inform(with: message)
    }
}
