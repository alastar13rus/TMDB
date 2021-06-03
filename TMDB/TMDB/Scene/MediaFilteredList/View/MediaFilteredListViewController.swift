//
//  MediaFilteredListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 30.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class MediaFilteredListViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: MediaFilteredListViewModel!
    private let dataSource = MediaListTableViewDataSource.dataSource()
    private let disposeBag = DisposeBag()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    private lazy var mediaFilteredListTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
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
        view.backgroundColor = .white
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(mediaFilteredListTableView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            mediaFilteredListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            mediaFilteredListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            mediaFilteredListTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            mediaFilteredListTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12),
        ])
    }
}

extension MediaFilteredListViewController: BindableType {
    func bindViewModel() {
        
        viewModel.output.title
            .asDriver(onErrorJustReturn: "")
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        mediaFilteredListTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(mediaFilteredListTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        mediaFilteredListTableView.rx
            .modelSelected(MediaCellViewModelMultipleSection.SectionItem.self)
            .bind(to: viewModel.input.selectedItem)
            .disposed(by: disposeBag)
        
        mediaFilteredListTableView.rx.willDisplayCell
            .filter { $0.indexPath.row + 5 == self.dataSource[$0.indexPath.section].items.count }
//            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged { $0.indexPath == $1.indexPath }
            .map { _ in Void() }
            .bind(to: viewModel.input.addItemsTrigger)
            .disposed(by: disposeBag)
        
        viewModel.output.isFetching
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.refreshItemsTrigger)
            .disposed(by: disposeBag)
    }
}

extension MediaFilteredListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
