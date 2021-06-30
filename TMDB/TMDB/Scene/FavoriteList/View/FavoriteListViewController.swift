//
//  FavoriteListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 07.06.2021.
//

import UIKit
import RxSwift
import RxDataSources

class FavoriteListViewController: UIViewController {
    
// MARK: - Properties
    var viewModel: FavoriteListViewModel!
    let dataSource = FavoriteListTableViewDataSource.dataSource()
    private let disposeBag = DisposeBag()
    
    private let favoriteListTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.input.viewWillAppear.accept(Void())
    }
    
// MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupHierarhy() {
        view.addSubview(favoriteListTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoriteListTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            favoriteListTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
}

extension FavoriteListViewController: BindableType {
    func bindViewModel() {
        
        viewModel.output.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        favoriteListTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(favoriteListTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        favoriteListTableView.rx
            .modelSelected(FavoriteCellViewModelMultipleSection.SectionItem.self)
            .bind(to: viewModel.input.selectedItem)
            .disposed(by: disposeBag)
        
        favoriteListTableView.rx.modelDeleted(FavoriteCellViewModelMultipleSection.SectionItem.self)
            .bind(to: viewModel.input.deletedItem)
            .disposed(by: disposeBag)
        
    }
}

extension FavoriteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .media: return 150
        case .people: return 150
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource[section] {
        case .mediaSection: return 40
        case .peopleSection: return 40
        }
    }
    
}
