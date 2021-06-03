//
//  TVEpisodeListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class TVEpisodeListViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: TVEpisodeListViewModel!
    let dataSource = TVEpisodeListTableViewDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    let tvEpisodeListTableView: UITableView = {
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
        navigationItem.title = "Список эпизодов"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(tvEpisodeListTableView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            tvEpisodeListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            tvEpisodeListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tvEpisodeListTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tvEpisodeListTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
}

extension TVEpisodeListViewController: BindableType {
    func bindViewModel() {
        
        tvEpisodeListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.output.sectionedItems.asDriver(onErrorJustReturn: []).drive(tvEpisodeListTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        tvEpisodeListTableView.rx.modelSelected(TVEpisodeCellViewModelMultipleSection.SectionItem.self).bind(to: viewModel.input.selectedItem).disposed(by: disposeBag)
    }
}

extension TVEpisodeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
