//
//  ImageListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

class ImageListViewModel: AnimatableSectionModelType {
    
    //    MARK: - Properties
    let title: String
    let items: [ImageCellViewModel]
    
    weak var coordinator: Coordinator?
    var contentForm: ContentForm = .portrait
    let disposeBag = DisposeBag()
    
    var sectionedItems: Observable<[ImageCellViewModelMultipleSection]> {
        return .just(
            [ImageCellViewModelMultipleSection(title: "Фото", items: items)]
        )
    }
    
    let selectedItem = PublishRelay<ImageCellViewModel>()
        
    //    MARK: - Init
    required init(original: ImageListViewModel, items: [ImageCellViewModel]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [ImageCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    convenience init(title: String, items: [ImageCellViewModel], coordinator: Coordinator?, contentForm: ContentForm) {
        self.init(title: title, items: items)
        self.coordinator = coordinator
        self.contentForm = contentForm
        
        subscribe()
    }
    
//    MARK: - Methods
    fileprivate func subscribe() {
        selectedItem.subscribe(onNext: { [weak self] vm in
            guard let self = self, let coordinator = self.coordinator else { return }
            switch coordinator {
            case let coordinator as MovieListCoordinator:
                coordinator.toImageFullScreen(withImageCellViewModel: vm, contentForm: self.contentForm)
            case let coordinator as TVListCoordinator:
                coordinator.toImageFullScreen(withImageCellViewModel: vm, contentForm: self.contentForm)
            case let coordinator as PeopleListCoordinator:
                coordinator.toImageFullScreen(withImageCellViewModel: vm, contentForm: self.contentForm)
            default:
                return
            }
        }).disposed(by: disposeBag)
    }
}

extension ImageListViewModel: IdentifiableType {
    var identity: String { return title }
}

extension ImageListViewModel: Equatable {
    static func ==(lhs: ImageListViewModel, rhs: ImageListViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
