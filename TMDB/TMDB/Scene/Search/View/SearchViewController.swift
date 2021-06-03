//
//  SearchViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 25.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class SearchViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: SearchViewModel!
//    let resultDataSource = SearchResultListTableViewDataSource.dataSource()
    let searchDataSource = SearchTableViewDataSource.dataSource()
    let disposeBag = DisposeBag()

    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.searchBarStyle = .minimal
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.placeholder = "Поиск"
        return searchController
    }()
    
    let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHierarhy()
        setupConstraints()
        
    }
    
//    MARK: - Methods
    
    fileprivate func setupUI() {
        navigationItem.title = "Поиск"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        view.backgroundColor = .white
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(searchTableView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    
}

extension SearchViewController: BindableType {
    func bindViewModel() {
        searchTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.sectionedItems.asDriver(onErrorJustReturn: []).drive(searchTableView.rx.items(dataSource: searchDataSource)).disposed(by: disposeBag)
        
        searchController.searchBar.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.query)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text
            .orEmpty
            .filter { $0.isEmpty }
            .map { _ in Void() }
            .bind(to: viewModel.input.removeResultListTrigger)
            .disposed(by: disposeBag)
        
        searchTableView.rx.modelSelected(SearchQuickRequestCellModelMultipleSection.SectionItem.self).bind(to: viewModel.input.selectedItem).disposed(by: disposeBag)
        
        searchController.rx.willDismiss.subscribe(onNext: { _ in print("willDismiss") }).disposed(by: disposeBag)
        searchController.rx.didDismiss.subscribe(onNext: { _ in print("didDismiss") }).disposed(by: disposeBag)
        searchController.rx.willPresent.subscribe(onNext: { _ in print("willPresent") }).disposed(by: disposeBag)
        searchController.rx.didPresent.subscribe(onNext: { _ in print("didPresent") }).disposed(by: disposeBag)
        
        searchTableView.rx.willDisplayCell
            .filter {
                let section = self.searchDataSource[$0.indexPath.section]
                guard case .resultSection(_, _) = section, $0.indexPath.row + 5 == section.items.count else { return false }
                return true
            }
//            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged { $0.indexPath == $1.indexPath }
            .map { _ in Void() }
            .bind(to: viewModel.input.loadNextPageTrigger)
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch searchDataSource[indexPath] {
        case .categoryList: return 130
        case .peopleList: return 250
        case .media: return 150
        case .people: return 150
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch searchDataSource[section] {
        case .categoryListSection: return 40
        case .peopleListSection: return 40
        case .resultSection: return 40
        }
    }
    
}

