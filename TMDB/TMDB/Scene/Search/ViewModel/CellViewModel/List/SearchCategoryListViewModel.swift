//
//  SearchCategoryListViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 25.05.2021.
//

import Foundation
import Domain
import RxSwift
import RxRelay

protocol SearchCategoryListViewModelDelegate: AnyObject {
    
    var searchFlowCoordinator: SearchFlowCoordinator? { get }

    func routing(with type: SearchCategory)
}

class SearchCategoryListViewModel {
    
    // MARK: - Properties
    let title: String
    let items: [SearchCategoryCellViewModel]
    
    weak var delegate: SearchCategoryListViewModelDelegate?
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    struct Input {
        let selectedItem = PublishRelay<SearchCategoryCellViewModel>()
    }
    
    struct Output {
        let sectionedItems = BehaviorRelay<[SearchCategoryListViewModelSection]>(value: [])
    }
    
    // MARK: - Init
    init(title: String, items: [SearchCategoryCellViewModel], delegate: SearchCategoryListViewModelDelegate?) {
        self.title = title
        self.items = items
        self.delegate = delegate
        
        setupInput()
        setupOutput()
    }
    
    fileprivate func setupInput() {
        input.selectedItem.subscribe(onNext: { [weak self] (vm) in
            guard let self = self, let delegate = self.delegate else { return }
            delegate.routing(with: vm.type)
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupOutput() {
        output.sectionedItems.accept([SearchCategoryListViewModelSection(title: title, items: items)])
    }
}
