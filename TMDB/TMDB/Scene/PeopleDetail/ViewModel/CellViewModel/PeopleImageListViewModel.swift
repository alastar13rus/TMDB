//
//  PeopleImageListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

class PeopleImageListViewModel: AnimatableSectionModelType {
    
    //    MARK: - Properties
    let title: String
    let items: [PeopleImageCellViewModel]
    weak var coordinator: Coordinator?
    let dataSource = BestCreditInMediaListDataSource.dataSource()
    
    var sectionedItems: Observable<[PeopleImageCellViewModelMultipleSection]> {
        return .just(
            [PeopleImageCellViewModelMultipleSection(title: "Фото", items: items)]
        )
    }
        
    //    MARK: - Init
    required init(original: PeopleImageListViewModel, items: [PeopleImageCellViewModel]) {
        self.title = original.title
        self.items = items
    }
    
    init(title: String, items: [PeopleImageCellViewModel]) {
        self.title = title
        self.items = items
    }
    
    convenience init(title: String, items: [PeopleImageCellViewModel], coordinator: Coordinator?) {
        self.init(title: title, items: items)
        self.coordinator = coordinator
    }
        

    }

extension PeopleImageListViewModel: IdentifiableType {
    var identity: String { return title }
}

extension PeopleImageListViewModel: Equatable {
    static func ==(lhs: PeopleImageListViewModel, rhs: PeopleImageListViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
