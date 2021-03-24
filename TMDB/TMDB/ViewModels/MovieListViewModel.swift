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
    var numberOfMovies = 0
    var requiredThresholdNumberOfCells = 5
    
    var actualThresholdNumberOfCells: Int {
        abs(numberOfMovies - input.willDisplayCellIndex.value)
    }
    
    var isRequiredNextFetching: Bool {
        actualThresholdNumberOfCells < requiredThresholdNumberOfCells
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
    
//    MARK: - Inputs
    
    struct Input {
        var selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
        var willDisplayCellIndex = BehaviorRelay<Int>(value: 0)
        let isRefreshing = BehaviorRelay<Bool>(value: false)
    }
    
    var input = Input()
    
    
//    MARK: - Outputs
    
    struct Output {
        var title = BehaviorRelay<String>(value: "")
        var categories = BehaviorRelay<[String]>(value: [])
        var selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
        var movies = BehaviorRelay<[MovieCellViewModel]>(value: [])
        var sectionedItems = BehaviorRelay<[MovieCellViewModelSection]>(value: [])
        let isFetching = BehaviorRelay<Bool>(value: false)
        let isRefreshing = BehaviorRelay<Bool>(value: false)
    }
    
    var output = Output()
    
    
    
//    MARK: - Init
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        
        self.setupOutput()
        self.setupInput()
        
    }
    
//    MARK: - Methods
    public func fetchMovies(api: API, completion: @escaping ([MovieCellViewModel]) -> Void) {
        
        guard !output.isFetching.value else {
            completion([])
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                completion([])
                return
            }
            
            self.networkManager.request(api) { [weak self] (result: Result<MovieListResponse, Error>) in
                
                guard let self = self else {
                    completion([])
                    return
                }
                
                self.output.isFetching.accept(true)
                
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        let fetchedMovies = response.results.map { MovieCellViewModel($0) }
                        print("===============================================")
                        print(self.input.selectedSegmentIndex.value)
                        completion(fetchedMovies)
                        
                        self.output.isFetching.accept(false)
                        
                    }
                case .failure(let error):
                    completion([])
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
    
        
        input.selectedSegmentIndex.skip(1).distinctUntilChanged().subscribe(onNext: { [weak self] index in
            
            guard let self = self else { return }
            
            self.currentPage = 1
            self.fetchMovies(api: TmdbAPI.movies(self.movieEndpoint)) { fetchedMovies in
                _movies.accept(fetchedMovies)
                self.numberOfMovies = _movies.value.count
            }
        }).disposed(by: disposeBag)
        
        input.willDisplayCellIndex.skip(1)
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .filter { _ in self.isRequiredNextFetching && self.numberOfMovies > 0 }
            .subscribe(onNext: { [weak self] (index) in
                
                guard let self = self else { return }
                
                self.currentPage += 1
                self.fetchMovies(api: TmdbAPI.movies(self.movieEndpoint)) { fetchedMovies in
                    var currentMovies = _movies.value
                    currentMovies.append(contentsOf: fetchedMovies)
                    var currentMoviesSet = Set(currentMovies)
                    var newCurrentMovies = [MovieCellViewModel]()
                    
                    _ = currentMovies
                        .filter { currentMoviesSet.contains($0) }
                        .compactMap { currentMoviesSet.remove($0) }
                        .map { newCurrentMovies.append($0) }

                    _movies.accept(newCurrentMovies)
                    self.numberOfMovies = _movies.value.count
                }
            }).disposed(by: disposeBag)
        
        _movies.skip(1).compactMap { $0 } .subscribe(onNext: { (cells) in
            _sectionedItems.accept([MovieCellViewModelSection(header: _title.value, items: cells)])
        }).disposed(by: disposeBag)
        
        input.isRefreshing.filter { $0 } .subscribe (onNext: { [weak self] _ in

            guard let self = self else { return }

            self.currentPage = 1
            self.fetchMovies(api: TmdbAPI.movies(self.movieEndpoint)) { fetchedMovies in
                _movies.accept(fetchedMovies)
                self.output.isRefreshing.accept(false)
            }
        }).disposed(by: disposeBag)

        self.output.title = _title
        self.output.categories = _categories
        self.numberOfMovies = _movies.value.count
        self.output.movies = _movies
        self.output.sectionedItems = _sectionedItems
        
    }
    
    private func setupInput() {
        
    }
    
}
