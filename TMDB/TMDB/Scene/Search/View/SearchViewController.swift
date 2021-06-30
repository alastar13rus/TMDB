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
    
// MARK: - Properties
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
        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var customActivityIndicator: CustomActivityIndicator = {
        let view = CustomActivityIndicator(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.setFillColor(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        view.setStrokeColor(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHierarhy()
        setupConstraints()
        
    }
    
// MARK: - Methods
    
    fileprivate func setupUI() {
        navigationItem.title = "Поиск"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        view.backgroundColor = .white
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(searchTableView)
        view.addSubview(customActivityIndicator)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            customActivityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            customActivityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
}

extension SearchViewController: BindableType {
    func bindViewModel() {
        searchTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(searchTableView.rx.items(dataSource: searchDataSource))
            .disposed(by: disposeBag)
        
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
        
        searchTableView.rx
            .modelSelected(SearchQuickRequestCellModelMultipleSection.SectionItem.self)
            .bind(to: viewModel.input.selectedItem)
            .disposed(by: disposeBag)
        
        searchTableView.rx.willDisplayCell
            .observeOn(MainScheduler.asyncInstance)
            .filter {
                let section = self.searchDataSource[$0.indexPath.section]
                guard case .resultSection = section, $0.indexPath.row == section.items.count - 1 else { return false }
                return true
            }
            .subscribeOn(MainScheduler.instance)
            .map { _ in Void() }
            .bind(to: viewModel.input.loadNextPageTrigger)
            .disposed(by: disposeBag)
        
        viewModel.output.isFetching.subscribe(onNext: { [weak self] (isFetching) in
            isFetching ?
                self?.customActivityIndicator.startAnimate([.move, .rotate]):
                self?.customActivityIndicator.stopAnimate()
        }).disposed(by: disposeBag)
        
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
