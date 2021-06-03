//
//  MediaListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.03.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MediaListViewController: UIViewController {
    
    
    //    MARK: - Property
    var viewModel: MediaListViewModel!
    private let disposeBag = DisposeBag()
    let mediaListDataSource = MediaListTableViewDataSource.dataSource()
    private let categoryListSegmentedControl = SegmentedControl()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    private(set) lazy var mediaListTableView: MediaListTableView = {
        let tableView = MediaListTableView(cell: MediaTableViewCell.self, refreshControl: refreshControl)
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
    private func setupUI() {
        view.backgroundColor = .white
        
    }
    
    private func setupHierarhy() {
        view.addSubview(categoryListSegmentedControl)
        view.addSubview(mediaListTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryListSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryListSegmentedControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            categoryListSegmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            categoryListSegmentedControl.heightAnchor.constraint(equalToConstant: 50),
            
            mediaListTableView.topAnchor.constraint(equalTo: categoryListSegmentedControl.bottomAnchor),
            mediaListTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mediaListTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mediaListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

//  MARK: - Extensions
extension MediaListViewController: BindableType {

    func bindViewModel() {
        viewModel.output.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.output.categories.subscribe(onNext: { (categories) in
            _ = categories.reversed()
                .map { self.categoryListSegmentedControl.insertSegment(withTitle: $0, at: 0, animated: true) }
        }).disposed(by: disposeBag)
        
        mediaListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(mediaListTableView.rx.items(dataSource: mediaListDataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.selectedSegmentIndex
            .asDriver().drive(categoryListSegmentedControl.rx.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        categoryListSegmentedControl.rx.selectedSegmentIndex
            .asDriver().drive(viewModel.input.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        viewModel.output.selectedSegmentIndex.map { _ in true }
            .subscribe(onNext: {  self.mediaListTableView.scrollsToTop = $0 })
            .disposed(by: disposeBag)
        
        mediaListTableView.rx.willDisplayCell
            .filter { $0.indexPath.row + 5 == self.mediaListDataSource[$0.indexPath.section].items.count }
            .distinctUntilChanged { $0.indexPath == $1.indexPath }
            .map { _ in Void() }
            .bind(to: viewModel.input.loadNextPageTrigger)
            .disposed(by: disposeBag)
        
        mediaListTableView.rx.modelSelected(MediaCellViewModelMultipleSection.SectionItem.self).map { (item) -> MediaCellViewModel in
            switch item { case .movie(let vm), .tv(let vm): return vm.self }
        }.bind(to: viewModel.input.selectedMedia).disposed(by: disposeBag)
        
        viewModel.output.isFetching
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.refreshItemsTrigger)
            .disposed(by: disposeBag)
        
                
    }


}

extension MediaListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
