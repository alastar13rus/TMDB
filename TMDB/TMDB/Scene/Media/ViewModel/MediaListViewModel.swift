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

class MediaListViewModel {
    

//    MARK: - Properties
    let networkManager: NetworkManagerProtocol
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
    let disposeBag = DisposeBag()
    
    var currentPage = 1
    var numberOfMedia = 0
    var requiredThresholdNumberOfCells = 5
    
    var actualThresholdNumberOfCells: Int {
        abs(numberOfMedia - input.willDisplayCellIndex.value)
    }
    
    var isRequiredNextFetching: Bool {
        actualThresholdNumberOfCells < requiredThresholdNumberOfCells
    }
    
    var screen: MediaListTableViewDataSource.Screen = .movie(MediaListTableViewDataSource.Screen.movieListInfo) {
        didSet {
            switch screen {
            case .movie(_):
                output.title = BehaviorRelay<String>(value: MediaListTableViewDataSource.Screen.movieListInfo.title)
                output.categories = BehaviorRelay<[String]>(value: MediaListTableViewDataSource.Screen.movieListInfo.categories)
            case .tv(_):
                output.title = BehaviorRelay<String>(value: MediaListTableViewDataSource.Screen.tvListInfo.title)
                output.categories = BehaviorRelay<[String]>(value: MediaListTableViewDataSource.Screen.tvListInfo.categories)
            }
            
        }
    }
    
    var movieEndpoint: TmdbAPI.MovieEndpoint {
        let index = self.input.selectedSegmentIndex.value
        
        switch index {
        case 0:
            return .topRated(page: currentPage)
        case 1:
            return .popular(page: currentPage)
        case 2:
            return .nowPlaying(page: currentPage)
        case 3:
            return .upcoming(page: currentPage)
        default:
            return .topRated(page: currentPage)
        }
    }
    
    var tvEndpoint: TmdbAPI.TVEndpoint {
        let index = self.input.selectedSegmentIndex.value
        
        switch index {
        case 0:
            return .topRated(page: currentPage)
        case 1:
            return .popular(page: currentPage)
        case 2:
            return .onTheAir(page: currentPage)
        case 3:
            return .airingToday(page: currentPage)
        default:
            return .topRated(page: currentPage)
        }
    }
    
//    MARK: - Inputs
            
            struct Input {
                let selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
                let willDisplayCellIndex = BehaviorRelay<Int>(value: 0)
                let isRefreshing = BehaviorRelay<Bool>(value: false)
                let selectedMedia = PublishRelay<MediaCellViewModel>()
            }
            
            var input = Input()
            
            
//    MARK: - Outputs
            
            struct Output {
                var title = BehaviorRelay<String>(value: "")
                var categories = BehaviorRelay<[String]>(value: [])
                let selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
                var media = BehaviorRelay<[MediaCellViewModel]>(value: [])
                var sectionedItems = BehaviorRelay<[MediaCellViewModelMultipleSection]>(value: [])
                let isFetching = BehaviorRelay<Bool>(value: false)
                let isRefreshing = BehaviorRelay<Bool>(value: false)
            }
            
            var output = Output()
    
//    MARK: - Init
    required init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        
        self.setupOutput()
//        self.setupInput()
        
    }
    
    
    //    MARK: - Methods
    public func fetch(completion: @escaping ([MediaCellViewModel]) -> Void) {
        
        guard !output.isFetching.value else { completion([]); return }
        
        switch self.screen {
        case .movie(_):
            self.networkManager.request(TmdbAPI.movies(self.movieEndpoint)) { [weak self] (result: Result<MediaListResponse<MovieModel>, Error>) in
                
                guard let self = self else { completion([]); return }
                
                self.output.isFetching.accept(true)
                
                switch result {
                case .success(let response):
                    let fetchedMedia = response.results.map { MediaCellViewModel($0) }
                    completion(fetchedMedia)
                    self.output.isFetching.accept(false)
                    
                case .failure: completion([]); break
                }
            }
        case .tv(_):
            self.networkManager.request(TmdbAPI.tv(self.tvEndpoint)) { [weak self] (result: Result<MediaListResponse<TVModel>, Error>) in
                
                guard let self = self else { completion([]); return }
                
                self.output.isFetching.accept(true)
                
                switch result {
                case .success(let response):
                    let fetchedMedia = response.results.map { MediaCellViewModel($0) }
                    completion(fetchedMedia)
                    self.output.isFetching.accept(false)
                    
                case .failure: completion([]); break
                }
            }
        }
        
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
            
            self.currentPage = 1
            self.fetch() { fetchedMedia in
                _media.accept(fetchedMedia)
                self.numberOfMedia = _media.value.count
            }
            
        }).disposed(by: disposeBag)
        
        input.willDisplayCellIndex.skip(1)
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .filter { _ in self.isRequiredNextFetching && self.numberOfMedia > 0 }
            .subscribe(onNext: { [weak self] (index) in
                
                guard let self = self else { return }
                
                self.currentPage += 1
                self.fetch() { fetchedMedia in
                    var currentMovies = _media.value
                    currentMovies.append(contentsOf: fetchedMedia)
                    var currentMoviesSet = Set(currentMovies)
                    var newCurrentMovies = [MediaCellViewModel]()
                    
                    _ = currentMovies
                        .filter { currentMoviesSet.contains($0) }
                        .compactMap { currentMoviesSet.remove($0) }
                        .map { newCurrentMovies.append($0) }
                    
                    _media.accept(newCurrentMovies)
                    self.numberOfMedia = _media.value.count
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
        
        input.isRefreshing.filter { $0 } .subscribe (onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.currentPage = 1
            self.fetch() { fetchedMedia in
//                _media.accept([])
                _media.accept(fetchedMedia)
                self.numberOfMedia = _media.value.count
                self.output.isRefreshing.accept(false)
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
        self.numberOfMedia = _media.value.count
        self.output.media = _media
        self.output.sectionedItems = _sectionedItems
        
    }
    
    
}
