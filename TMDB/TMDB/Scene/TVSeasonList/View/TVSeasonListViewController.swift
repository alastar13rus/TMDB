//
//  TVSeasonListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class TVSeasonListViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: TVSeasonListViewModel!
    let dataSource = TVSeasonListTableViewDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    let tvSeasonListTableView: UITableView = {
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
        view.backgroundColor = .white
        navigationItem.title = "Список сезонов"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(tvSeasonListTableView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            tvSeasonListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            tvSeasonListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tvSeasonListTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tvSeasonListTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
}

extension TVSeasonListViewController: BindableType {
    func bindViewModel() {
        
        tvSeasonListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.output.sectionedItems.asDriver(onErrorJustReturn: []).drive(tvSeasonListTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
}

extension TVSeasonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
