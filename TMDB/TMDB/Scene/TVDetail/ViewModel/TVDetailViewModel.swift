//
//  TVDetailViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import Foundation
import RxSwift
import RxRelay

class TVDetailViewModel: DetailViewModelType {
    
//    MARK: - Properties
    let networkManager: NetworkManagerProtocol
    let detailID: String
    weak var coordinator: Coordinator?
    
    
//    MARK: - Input
    
    struct Input {
        
    }
    
    let input = Input()
    
    
    
//    MARK: - Output
    
    struct Output {
        let title = BehaviorRelay<String>(value: "")
        let posterAbsolutePath = BehaviorRelay<URL?>(value: URL(string: ""))
        let backdropAbsolutePath = BehaviorRelay<URL?>(value: URL(string: ""))
        let sectionedItems = BehaviorRelay<[TVDetailCellViewModelMultipleSection]>(value: [])
    }
    
    let output = Output()
    
//    MARK: - Init
    required init(with detailID: String, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.detailID = detailID
        fetch { [weak self] (tvDetail) in
            guard let self = self else { return }
            
            let tvPosterWrapperSection: TVDetailCellViewModelMultipleSection =
                .tvPosterWrapperSection(
                    title: "Poster",
                    items: [.tvPosterWrapper(vm: TVPosterWrapperCellViewModel(tvDetail))])
            
            let tvOverviewSection: TVDetailCellViewModelMultipleSection =
                .tvOverviewSection(
                    title: "Overview",
                    items: [.tvOverview(vm: TVOverviewCellViewModel(tvDetail))])
            
            let tvRuntimeSection: TVDetailCellViewModelMultipleSection =
                .tvRuntimeSection(
                    title: "Продолжительность",
                    items: [.tvRuntime(vm: TVRuntimeCellViewModel(tvDetail))])
            
            let tvGenresSection: TVDetailCellViewModelMultipleSection =
                .tvGenresSection(
                    title: "Жанры",
                    items: [.tvGenres(vm: TVGenresCellViewModel(tvDetail))])
            
            let creators = tvDetail.createdBy.map { TVCreatorWithPhotoCellViewModel($0) }
            let tvCreatorsSection: TVDetailCellViewModelMultipleSection =
                .tvCreatorsSection(
                    title: "Создатели",
                    items: creators.map { .tvCreators(vm: $0) })
            
            let tvStatusSection: TVDetailCellViewModelMultipleSection =
                .tvStatusSection(
                    title: "Статус",
                    items: [.tvStatus(vm: TVStatusCellViewModel(tvDetail))])
            
            self.output.sectionedItems.accept([
                tvPosterWrapperSection,
                tvOverviewSection,
                tvRuntimeSection,
                tvGenresSection,
                tvCreatorsSection,
                tvStatusSection,
            ])
            
            switch tvPosterWrapperSection.items[0] {
            case .tvPosterWrapper(let vm):
                self.output.title.accept(vm.title)
                
                var posterAbsolutePath: URL? {
                    return ImageURL.poster(.w500, vm.posterPath).fullURL
                }
                
                var backdropAbsolutePath: URL? {
                    return ImageURL.backdrop(.w780, vm.backdropPath).fullURL
                }
                self.output.posterAbsolutePath.accept(posterAbsolutePath)
                self.output.backdropAbsolutePath.accept(backdropAbsolutePath)

                
            default: break
            }
            
        }
        setupOutput()
    }
    
//    MARK: - Methods
    
    private func fetch(completion: @escaping (TVDetailModel) -> Void) {
        self.networkManager.request(TmdbAPI.tv(.details(mediaID: detailID))) { [weak self] (result: Result<TVDetailModel, Error>) in
                
                switch result {
                case .success(let tvDetail):
                    completion(tvDetail)
                    
                case .failure(let error): break
                }
            }
        
    }
    
    private func setupOutput() {
        
    }
    
    
    
    
}
