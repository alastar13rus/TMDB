//
//  FilterOptionListMediaViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class FilterOptionListMediaViewController: UIViewController {
    
// MARK: - Properties
    var viewModel: FilterOptionListMediaViewModel!
    let dataSource = FilterOptionListMediaTableViewDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    let filterOptionListMediaByYearTableView: UITableView = {
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
    
// MARK: - Methods
    fileprivate func setupUI() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(filterOptionListMediaByYearTableView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            filterOptionListMediaByYearTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            filterOptionListMediaByYearTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            filterOptionListMediaByYearTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            filterOptionListMediaByYearTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12)
        ])
    }
}

extension FilterOptionListMediaViewController: BindableType {
    func bindViewModel() {
        
        filterOptionListMediaByYearTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(filterOptionListMediaByYearTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        filterOptionListMediaByYearTableView.rx
            .modelSelected(FilterOptionListMediaModelMultipleSection.SectionItem.self)
            .bind(to: viewModel.input.selectedItem)
            .disposed(by: disposeBag)
    }
}

extension FilterOptionListMediaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
