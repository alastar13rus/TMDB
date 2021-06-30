//
//  FilterOptionListMediaViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.05.2021.
//

import Foundation
import Domain
import RxSwift
import RxRelay

class FilterOptionListMediaViewModel {
    
// MARK: - Properties
    let searchCategory: SearchCategory
    
    var mediaType: Domain.MediaType {
        switch searchCategory {
        case .movieListByYears, .movieListByGenres: return .movie
        case .tvListByYears, .tvListByGenres: return .tv
        }
    }
    
    weak var coordinator: NavigationCoordinator?
    let useCaseProvider: Domain.UseCaseProvider
    
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let selectedItem = PublishRelay<FilterOptionListMediaModelMultipleSection.SectionItem>()
    }
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let sectionedItems = BehaviorRelay<[FilterOptionListMediaModelMultipleSection]>(value: [])
    }
    
// MARK: - Init
    init(searchCategory: SearchCategory, useCaseProvider: Domain.UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        self.searchCategory = searchCategory
        
        setupInput()
        setupOutput()
    }
    
// MARK: - Methods
    fileprivate func setupInput() {
        input.selectedItem.subscribe(onNext: { (option) in
            guard let coordinator = self.coordinator as? SearchFlowCoordinator else { return }
            switch option {
            case .mediaByYear(let vm):
                coordinator.toMediaListByYear(vm.year, mediaType: vm.mediaType)
            case .mediaByGenre(let vm):
                coordinator.toMediaListByGenre(vm.genreID, genreName: vm.genreName, mediaType: vm.mediaType)
            }
            
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupOutput() {
        switch searchCategory {
        case .movieListByGenres(let title): output.title.accept(title)
        case .movieListByYears(let title): output.title.accept(title)
        case .tvListByGenres(let title): output.title.accept(title)
        case .tvListByYears(let title): output.title.accept(title)
        }
        
        switch searchCategory {
        case .movieListByYears(let title):
            fetchFilterMediaByYear(mediaType: mediaType) { [weak self] (options) in
                self?.output.sectionedItems.accept([.mediaByYearSection(title: title, items: options.map { .mediaByYear(vm: $0) })])
            }
        case .tvListByYears(let title):
            fetchFilterMediaByYear(mediaType: mediaType) { [weak self] (options) in
                self?.output.sectionedItems.accept([.mediaByYearSection(title: title, items: options.map { .mediaByYear(vm: $0) })])
            }
        case .movieListByGenres(let title):
            fetchFilterMediaByGenre(mediaType: mediaType) { [weak self] (options) in
                self?.output.sectionedItems.accept([.mediaWithGenreSection(title: title, items: options.map { .mediaByGenre(vm: $0) })])
            }
        case .tvListByGenres(let title):
            fetchFilterMediaByGenre(mediaType: mediaType) { [weak self] (options) in
                self?.output.sectionedItems.accept([.mediaWithGenreSection(title: title, items: options.map { .mediaByGenre(vm: $0) })])
            }
        }
    }
    
    fileprivate func fetchFilterMediaByYear(mediaType: MediaType, completion: @escaping ([FilterOptionMediaByYearCellViewModel]) -> Void) {
        let useCase = useCaseProvider.makeSearchUseCase()
        useCase.showMediaByYearFilterOptions(mediaType: mediaType) { (options) in
            completion(options.map { FilterOptionMediaByYearCellViewModel($0) })
        }
    }
    
    fileprivate func fetchFilterMediaByGenre(mediaType: MediaType, completion: @escaping ([FilterOptionMediaByGenreCellViewModel]) -> Void) {
        let useCase = useCaseProvider.makeSearchUseCase()
        useCase.showMediaByGenreFilterOptions(mediaType: mediaType) { (result) in
            guard case .success(let options) = result else { return }
            
            completion(options.genres.map { FilterOptionMediaByGenreCellViewModel($0, mediaType: mediaType) })
        }
    }
    
}
