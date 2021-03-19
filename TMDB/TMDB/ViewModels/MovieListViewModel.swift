//
//  MovieListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.03.2021.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListViewModel: ViewModelType {
    
//    MARK: - Properties
    let networkManager: NetworkManagerProtocol
    weak var coordinator: MovieListCoordinator?
    let disposeBag = DisposeBag()
    
    var currentPage = 1
    let isFetching = BehaviorRelay<Bool>(value: false)
    
//    MARK: - Inputs
    
    struct Input {
        var selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
        var willDisplayCellIndex = BehaviorRelay<Int>(value: 0)
    }
    
    var input = Input()
    
    
//    MARK: - Outputs
    
    struct Output {
        var title = BehaviorRelay<String>(value: "")
        var categories = BehaviorRelay<[String]>(value: [])
        var selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
        var movies = BehaviorRelay<[MovieCellViewModel]>(value: [])
        var sectionedItems = BehaviorRelay<[MovieCellViewModelSection]>(value: [])
    }
    
    var output = Output()
    
    
    
//    MARK: - Init
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        
        self.setupOutput()
        self.setupInput()
        
    }
    
//    MARK: - Methods
    private func fetchMovies(api: API, completion: @escaping ([MovieCellViewModel]) -> Void) {
        
        guard !isFetching.value else { return }
        
        var fetchedMovies = [MovieCellViewModel]()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.networkManager.request(api) { [weak self] (result: Result<MovieListResponse, Error>) in
                
                guard let self = self else { return }
                
                self.isFetching.accept(true)
                
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        fetchedMovies = response.results.map { MovieCellViewModel($0) }
                        completion(fetchedMovies)
                        
                        self.isFetching.accept(false)
                        
                    }
                case .failure(let error):
                    break
                }
            }
        }
        
        
    }
    
    private func setupOutput() {
        let _title = BehaviorRelay<String>(value: "Рейтинг фильмов")
        let _categories = BehaviorRelay<[String]>(value: ["ТОП рейтинга", "Популярные", "Свежие", "Ожидаемые"])
        let _movies = BehaviorRelay<[MovieCellViewModel]>(value: [])
        let _sectionedItems = BehaviorRelay<[MovieCellViewModelSection]>(value: [])
        let _selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
        
        var _movieEndpoint: TmdbAPI.MovieEndpoint {
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
        
        
        
        input.selectedSegmentIndex.distinctUntilChanged().subscribe(onNext: { index in
            _selectedSegmentIndex.accept(index)
            self.currentPage = 1
            self.fetchMovies(api: TmdbAPI.movies(_movieEndpoint)) { fetchedMovies in
                _movies.accept(fetchedMovies)
            }
        }).disposed(by: disposeBag)
        
        input.willDisplayCellIndex
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (index) in
                
                guard let self = self else { return }
                guard index >= self.output.movies.value.count - 5 && !self.output.movies.value.isEmpty else { return }
                
                self.currentPage += 1
                self.fetchMovies(api: TmdbAPI.movies(_movieEndpoint)) { fetchedMovies in
                    var currentMovies = _movies.value
                    currentMovies.append(contentsOf: fetchedMovies)
                    _movies.accept(currentMovies)
                }
            }).disposed(by: disposeBag)
        
        _movies.subscribe(onNext: { (cells) in
            _sectionedItems.accept([MovieCellViewModelSection(header: _title.value, items: cells)])
        }).disposed(by: disposeBag)
        
        self.output.title = _title
        self.output.categories = _categories
        self.output.selectedSegmentIndex = _selectedSegmentIndex
        self.output.movies = _movies
        self.output.sectionedItems = _sectionedItems
        
    }
    
    private func setupInput() {
        
    }
    
}
