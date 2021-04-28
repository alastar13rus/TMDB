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
    let dataSource = BestCreditInMediaListDataSource.dataSource()
    
    var sectionedItems: Observable<[ImageCellViewModelMultipleSection]> {
        return .just(
            [ImageCellViewModelMultipleSection(title: "Фото", items: items)]
        )
    }
        
    //    MARK: - Init
    required init(original: ImageListViewModel, items: [ImageCellViewModel]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [ImageCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    convenience init(title: String, items: [ImageCellViewModel], coordinator: Coordinator?) {
        self.init(title: title, items: items)
        self.coordinator = coordinator
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
