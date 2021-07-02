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

class MediaListViewModel {
    
    typealias Section = MediaCellViewModelMultipleSection
    typealias Item = Section.SectionItem
    
    // MARK: - Properties
    private let useCaseProvider: Domain.UseCaseProvider
    private let networkMonitor: Domain.NetworkMonitor
    
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
        var currentPage = 0
        var withReplace = true
        var numberOfMedia: Int { media.count }
        var media: [MediaCellViewModel] = []
        var dictOfMediaKeys = [String: Int]()
    }
    
    var screen: MediaListTableViewDataSource.Screen = .movie(MediaListTableViewDataSource.Screen.movieListInfo) {
        didSet {
            switch screen {
            case .movie:
                output.title = BehaviorRelay<String>(value: MediaListTableViewDataSource.Screen.movieListInfo.title)
                output.categories = BehaviorRelay<[String]>(value: MediaListTableViewDataSource.Screen.movieListInfo.categories)
                state.currentPage = 1
                state.withReplace = true
                
                useCase = useCaseProvider.makeMovieListUseCase()
                self.setupOutput(withReplace: true)
                
            case .tv:
                output.title = BehaviorRelay<String>(value: MediaListTableViewDataSource.Screen.tvListInfo.title)
                output.categories = BehaviorRelay<[String]>(value: MediaListTableViewDataSource.Screen.tvListInfo.categories)
                state.currentPage = 1
                state.withReplace = true
                
                useCase = useCaseProvider.makeTVListUseCase()
                self.setupOutput(withReplace: true)
            }
            
        }
    }
    
    private lazy var useCase: Domain.MediaListUseCase? = useCaseProvider.makeMovieListUseCase()
    
    var movieMethod: ((Int, @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) -> Void)? {
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
    
    var tvMethod: ((Int, @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) -> Void)? {
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
    
    // MARK: - Inputs
    
    struct Input {
        let selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
        let refreshItemsTrigger = PublishRelay<Void>()
        let loadNextPageTrigger = PublishRelay<Void>()
        let selectedMedia = PublishRelay<Item>()
    }
    
    var input = Input()
    
    // MARK: - Outputs
    
    struct Output {
        var title = BehaviorRelay<String>(value: "")
        var categories = BehaviorRelay<[String]>(value: [])
        let selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
        var sectionedItems = BehaviorRelay<[Section]>(value: [])
        let isFetching = BehaviorRelay<Bool>(value: false)
    }
    
    var output = Output()
    
    // MARK: - Init
    required init(useCaseProvider: Domain.UseCaseProvider, networkMonitor: Domain.NetworkMonitor) {
        self.useCaseProvider = useCaseProvider
        self.networkMonitor = networkMonitor
        
        self.handleInput()
        
    }
    
    // MARK: - Methods
    
    func setupOutput(withReplace: Bool) {
        switch screen {
        case .movie:
            fetchMovieList(withReplace: withReplace) { [weak self] result in
                guard let self = self else { return }
                let fetchedMedia = self.handle(result, withReplace: withReplace)
                self.configureSections(with: fetchedMedia, withReplace: withReplace)
            }
        case .tv:
            fetchTVList(withReplace: withReplace) { [weak self] result in
                guard let self = self else { return }
                let fetchedMedia = self.handle(result, withReplace: withReplace)
                self.configureSections(with: fetchedMedia, withReplace: withReplace)
            }
        }
    }
    
    private func handleInput() {
        
        input.selectedSegmentIndex.distinctUntilChanged().skip(1)
            .subscribe(onNext: { [weak self] _ in
                self?.setupOutput(withReplace: true)
            }).disposed(by: disposeBag)
        
        input.loadNextPageTrigger
            .subscribe(onNext: { [weak self] _ in
                self?.setupOutput(withReplace: false)
            }).disposed(by: disposeBag)
        
        input.refreshItemsTrigger.subscribe(onNext: { [weak self] _ in
            self?.setupOutput(withReplace: true)
        }).disposed(by: disposeBag)
        
        input.selectedMedia.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case .movie(let vm):
                guard let coordinator = self.coordinator as? MovieFlowCoordinator else { return }
                coordinator.toDetail(with: vm.id)
            case .tv(let vm):
                guard let coordinator = self.coordinator as? TVFlowCoordinator else { return }
                coordinator.toDetail(with: vm.id)
            }
            
        }).disposed(by: disposeBag)
    }
    
    public func fetchMovieList(withReplace: Bool, _ completion: @escaping (Result<MediaListResponse<MovieModel>, Error>) -> Void) {
        
        guard !output.isFetching.value else { return }
        
        output.isFetching.accept(true)
        
        let page = (withReplace) ? 1 : state.currentPage + 1
        movieMethod?(page) { completion($0) }
    }
    
    public func fetchTVList(withReplace: Bool, _ completion: @escaping (Result<MediaListResponse<TVModel>, Error>) -> Void) {
        
        guard !output.isFetching.value else { return }
        
        output.isFetching.accept(true)
        
        let page = (withReplace) ? 1 : state.currentPage + 1
        tvMethod?(page) { completion($0) }
    }
    
    private func handle<T: MediaProtocol>(_ result: Result<MediaListResponse<T>, Error>, withReplace: Bool) -> [MediaCellViewModel] {
        
        output.isFetching.accept(false)
        switch result {
        case .success(let response):
            state.currentPage = response.page
            self.output.isFetching.accept(false)
            let fetchedMedia = response.results.map { MediaCellViewModel($0) }
            return fetchedMedia
        case .failure(let error):
            inform(with: error.localizedDescription)
            output.isFetching.accept(false)
            return []
        }
    }
    
    private func configureSections(with fetchedMedia: [MediaCellViewModel], withReplace: Bool) {
         
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            if withReplace {
                self.state.media = fetchedMedia
                self.state.dictOfMediaKeys.removeAll()
            } else {
                let newMedia = fetchedMedia.filter { self.state.dictOfMediaKeys[$0.id] == nil }
                self.state.media.append(contentsOf: newMedia)
            }
            self.state.media.enumerated().forEach { self.state.dictOfMediaKeys[$1.id] = $0 }
            
            switch self.screen {
            case .movie:
                let sections: [Section] = [.movieSection(title: self.output.title.value, items: self.state.media.map { .movie(vm: $0) })]
                DispatchQueue.main.async {
                    self.output.sectionedItems.accept(sections)
                }
            case .tv:
                let sections: [Section] = [.tvSection(title: self.output.title.value, items: self.state.media.map { .tv(vm: $0) })]
                DispatchQueue.main.async {
                    self.output.sectionedItems.accept(sections)
                }
            }
        }
    }
    
    private func inform(with message: String) {
        networkMonitor.alertCoordinator?.inform(with: message)
    }
}
