//
//  PeopleShortListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 25.05.2021.
//

import Foundation
import RxSwift
import RxRelay

protocol PeopleShortListViewModelDelegate: AnyObject {
    var peopleShortListDelegateCoordinator: ToPeopleRoutable? { get }
    func routing(with peopleID: String)
}

extension PeopleShortListViewModelDelegate {
    func routing(with peopleID: String) {
        guard let coordinator = peopleShortListDelegateCoordinator else { return }
            coordinator.toPeople(with: peopleID)
    }
}

class PeopleShortListViewModel {
    
    // MARK: - Properties
    let title: String
    let items: [PeopleCellViewModel]
    weak var delegate: PeopleShortListViewModelDelegate?
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let selectedItem = PublishRelay<String>()
    }
    
    struct Output {
        var sectionedItems = BehaviorRelay<[PeopleShortListViewModelSection]>(value: [])
    }
    
    // MARK: - Init
    init(title: String, items: [PeopleCellViewModel], delegate: PeopleShortListViewModelDelegate?) {
        self.title = title
        self.items = items
        self.delegate = delegate
        
        setupInput()
        setupOutput()
    }
    
    fileprivate func setupInput() {
        input.selectedItem.subscribe(onNext: { [weak self] (peopleID) in
            guard let self = self, let delegate = self.delegate else { return }
            delegate.routing(with: peopleID)
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupOutput() {
        output.sectionedItems.accept([PeopleShortListViewModelSection(title: title, items: items)])
    }
}
