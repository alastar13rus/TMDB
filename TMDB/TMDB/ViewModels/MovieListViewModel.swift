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
        
    }
    
    lazy var input: Input = { setupInput() }()
    
    
//    MARK: - Outputs
    
    struct Output {
        let title: BehaviorRelay<String>
        let categories: BehaviorRelay<[String]>
        let movies: BehaviorRelay<[MovieCellViewModel]>
        let sectionedItems: BehaviorRelay<[MovieCellViewModelSection]>
    }
    
    lazy var output: Output = { setupOutput() }()
    
    
    
//    MARK: - Init
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        
        
        
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
    
    private func setupOutput() -> Output {
        let _title = BehaviorRelay<String>(value: "Рейтинг фильмов")
        let _categories = BehaviorRelay<[String]>(value: ["ТОП рейтинга", "Популярные", "Свежие", "Ожидаемые"])
        let _movies = BehaviorRelay<[MovieCellViewModel]>(value: [])
        let _sectionedItems = BehaviorRelay<[MovieCellViewModelSection]>(value: [])
        
        self.fetchMovies(api: TmdbAPI.movies(.topRated(page: 1))) { fetchedMovies in
            _movies.accept(fetchedMovies)
        }
        
        _movies.subscribe(onNext: { (cells) in
            _sectionedItems.accept([MovieCellViewModelSection(header: "efsd", items: cells)])
        }).disposed(by: disposeBag)
        
        return Output(title: _title, categories: _categories, movies: _movies, sectionedItems: _sectionedItems)
    }
    
    private func setupInput() -> Input {
        return Input()
    }
}
