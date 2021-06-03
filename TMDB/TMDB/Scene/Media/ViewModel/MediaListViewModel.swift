//
//  MediaListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 07.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import Swinject
import Domain
import NetworkPlatform

class MediaListViewModel {
    

//    MARK: - Properties
    private let useCaseProvider: Domain.UseCaseProvider
    
    weak var coordinator: Coordinator? {
        didSet {
            if coordinator is MovieFlowCoordinator {
                screen = .movie(MediaListTableViewDataSource.Screen.movieListInfo)
            }
            if coordinator is TVFlowCoordinator {
                screen = .tv(MediaListTableViewDataSource.Screen.tvListInfo)
            }
        }
    }
    private let disposeBag = DisposeBag()
    
    var state = State()
    
    struct State {
        var currentPage = 1
        var numberOfMedia = 0
    }
    
    var screen: MediaListTableViewDataSource.Screen = .movie(MediaListTableViewDataSource.Screen.movieListInfo) {
        didSet {
            switch screen {
            case .movie:
                output.title = BehaviorRelay<String>(value: MediaListTableViewDataSource.Screen.movieListInfo.title)
                output.categories = BehaviorRelay<[String]>(value: MediaListTableViewDataSource.Screen.movieListInfo.categories)
                
                useCase = useCaseProvider.makeMovieListUseCase()
            case .tv:
                output.title = BehaviorRelay<String>(value: MediaListTableViewDataSource.Screen.tvListInfo.title)
                output.categories = BehaviorRelay<[String]>(value: MediaListTableViewDataSource.Screen.tvListInfo.categories)
                
                useCase = useCaseProvider.makeTVListUseCase()
            }
            
        }
    }
        
    private var useCase: Domain.MediaListUseCase?
    
    var movieMethod: ((Int, @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) -> ())? {
        let index = self.input.selectedSegmentIndex.value
        
        guard let useCase = useCase as? Domain.MovieListUseCase else { return nil }
        
            switch index {
            case 0: return useCase.topRated(page:completion:)
            case 1: return useCase.popular(page:completion:)
            case 2: return useCase.nowPlaying(page:completion:)
            case 3: return useCase.upcoming(page:completion:)
            default: return useCase.topRated(page:completion:)
            }
    }
    
    var tvMethod: ((Int, @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) -> ())? {
        let index = self.input.selectedSegmentIndex.value
        
        guard let useCase = useCase as? Domain.TVListUseCase else { return nil }
            switch index {
            case 0: return useCase.topRated(page:completion:)
            case 1: return useCase.popular(page:completion:)
            case 2: return useCase.onTheAir(page:completion:)
            case 3: return useCase.airingToday(page:completion:)
            default: return useCase.topRated(page:completion:)
            }
    }
    
//    MARK: - Inputs
            
            struct Input {
                let selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
                let refreshItemsTrigger = PublishRelay<Void>()
                let loadNextPageTrigger = PublishRelay<Void>()
                let selectedMedia = PublishRelay<MediaCellViewModel>()
            }
            
            var input = Input()
            
            
//    MARK: - Outputs
            
            struct Output {
                var title = BehaviorRelay<String>(value: "")
                var categories = BehaviorRelay<[String]>(value: [])
                let selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
                var sectionedItems = BehaviorRelay<[MediaCellViewModelMultipleSection]>(value: [])
                let isFetching = BehaviorRelay<Bool>(value: false)
            }
            
            var output = Output()
    
//    MARK: - Init
    required init(useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        
        self.setupOutput()
//        self.setupInput()
        
    }
    
    
    //    MARK: - Methods
    
    public func fetch(completion: @escaping ([MediaCellViewModel]) -> Void) {
        
        guard !output.isFetching.value else { completion([]); return }
        
        self.output.isFetching.accept(true)
        
        switch screen {
        
        case .movie:
            self.output.isFetching.accept(true)
            movieMethod?(state.currentPage) { [weak self] (result: Result) in
                guard let self = self else { return }
                completion(self.handleMovie(result))
            }
            
        case .tv:
            self.output.isFetching.accept(true)
            tvMethod?(state.currentPage) { [weak self] (result: Result) in
                guard let self = self else { return }
                completion(self.handleTV(result))
            }
        }
    }

private func handleMovie(_ result: Result<MediaListResponse<MovieModel>, Error>) -> [MediaCellViewModel] {
    
    output.isFetching.accept(false)
    switch result {
    case .success(let response):
        let fetchedMedia = response.results.map { MediaCellViewModel($0) }
        return fetchedMedia
    case .failure: return []; break
    }
}

private func handleTV(_ result: Result<MediaListResponse<TVModel>, Error>) -> [MediaCellViewModel] {
    
    switch result {
    case .success(let response):
        let fetchedMedia = response.results.map { MediaCellViewModel($0) }
        self.output.isFetching.accept(false)
        return fetchedMedia
    case .failure: return []; break
    }
    output.isFetching.accept(false)
}
    
    
    private func setupOutput() {
        var _title = BehaviorRelay<String>(value: "")
        var _categories = BehaviorRelay<[String]>(value: [])
        let _media = BehaviorRelay<[MediaCellViewModel]>(value: [])
        let _sectionedItems = BehaviorRelay<[MediaCellViewModelMultipleSection]>(value: [])
        
        switch self.screen {
        case .movie(let movieListInfo):
            _title = BehaviorRelay<String>(value: movieListInfo.title)
            _categories = BehaviorRelay<[String]>(value: movieListInfo.categories)
        case .tv(let tvListInfo):
            _title = BehaviorRelay<String>(value: tvListInfo.title)
            _categories = BehaviorRelay<[String]>(value: tvListInfo.categories)
        }
        
        input.selectedSegmentIndex.skip(1).distinctUntilChanged().subscribe(onNext: { [weak self] index in
            guard let self = self else { return }
            
            self.state.currentPage = 1
            self.fetch() { fetchedMedia in
                _media.accept(fetchedMedia)
                self.state.numberOfMedia = _media.value.count
            }
            
        }).disposed(by: disposeBag)
        
        input.loadNextPageTrigger
            .subscribe(onNext: { [weak self] _ in
                
                guard let self = self else { return }
                
                self.state.currentPage += 1
                self.fetch() { fetchedMedia in
                    var currentMedia = _media.value
                    currentMedia.append(contentsOf: fetchedMedia)
                    var currentMediaSet = Set(currentMedia)
                    var newCurrentMedia = [MediaCellViewModel]()
                    
                    _ = currentMedia
                        .filter { currentMediaSet.contains($0) }
                        .compactMap { currentMediaSet.remove($0) }
                        .map { newCurrentMedia.append($0) }
                    
                    _media.accept(newCurrentMedia)
                    self.state.numberOfMedia = _media.value.count
                }
                
            }).disposed(by: disposeBag)
        
        _media.skip(1).distinctUntilChanged().subscribe(onNext: { [weak self] (cells: [MediaCellViewModel]) in
            guard let self = self else { return }
            
            let segmentIndex = self.input.selectedSegmentIndex.value
            let category = _categories.value[segmentIndex]
            
            guard !cells.isEmpty else { return }
            
            switch self.screen {
            case .movie(_):
                _sectionedItems.accept([ .movieSection(title: _title.value, items: cells.map { .movie(vm: $0) }) ])
            case .tv(_):
                _sectionedItems.accept([ .tvSection(title: _title.value, items: cells.map { .tv(vm: $0) }) ])
            }
            
            
        }).disposed(by: disposeBag)
        
        input.refreshItemsTrigger.subscribe (onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.state.currentPage = 1
            self.fetch() { fetchedMedia in
//                _media.accept([])
                _media.accept(fetchedMedia)
                self.state.numberOfMedia = _media.value.count
                self.output.isFetching.accept(false)
            }
        }).disposed(by: disposeBag)
        
        input.selectedMedia.subscribe(onNext: { [weak self] (mediaCellViewModel: MediaCellViewModel) in
            if let self = self, let coordinator = self.coordinator as? MovieFlowCoordinator {
                coordinator.toDetail(with: mediaCellViewModel.id)
            }
            
            if let self = self, let coordinator = self.coordinator as? TVFlowCoordinator {
                coordinator.toDetail(with: mediaCellViewModel.id)
            }
            
        }).disposed(by: disposeBag)
        
        self.output.title = _title
        self.output.categories = _categories
        self.state.numberOfMedia = _media.value.count
        self.output.sectionedItems = _sectionedItems
        
    }
    
    
}
