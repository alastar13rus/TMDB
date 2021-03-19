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
    
    
    
//    MARK: - Inputs
    
    struct Input {
        var selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
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
        
    }
    
//    MARK: - Methods
    private func fetchMovies(api: API, completion: @escaping ([MovieCellViewModel]) -> Void) {
        var fetchedMovies = [MovieCellViewModel]()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.networkManager.request(api) { (result: Result<MovieListResponse, Error>) in
                
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        fetchedMovies = response.results.map { MovieCellViewModel($0) }
                        completion(fetchedMovies)
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
        var _selectedSegmentIndex = BehaviorRelay<Int>(value: 0)
        
        var _movieEndpoint: TmdbAPI.MovieEndpoint {
            let index = self.input.selectedSegmentIndex.value
            switch index {
            case 0:
                return .topRated(page: 1)
            case 1:
                return .popular(page: 1)
            case 2:
                return .nowPlaying(page: 1)
            case 3:
                return .upcoming(page: 1)
            default:
                return .topRated(page: 1)
            }
        }
        
        
        
        input.selectedSegmentIndex.subscribe(onNext: { index in
            _selectedSegmentIndex.accept(index)
            self.fetchMovies(api: TmdbAPI.movies(_movieEndpoint)) { fetchedMovies in
                self.output.movies.accept(fetchedMovies)
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
    
}
