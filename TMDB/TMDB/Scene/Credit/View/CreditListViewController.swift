//
//  CreditListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class CreditListViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: CreditListViewModel!
    let dataSource = CreditListDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    lazy var creditListTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.register(CreditCastCell.self, forCellReuseIdentifier: String(describing: CreditCastCell.self))
        tableView.register(CreditCrewCell.self, forCellReuseIdentifier: String(describing: CreditCrewCell.self))
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
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(creditListTableView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            creditListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            creditListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            creditListTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            creditListTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}

//  MARK: - Extension: BindableType
extension CreditListViewController: BindableType {
    
    func bindViewModel() {
        viewModel.output.sectionedItems.asDriver(onErrorJustReturn: []).drive(creditListTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        viewModel.output.title.asDriver(onErrorJustReturn: "").drive(navigationItem.rx.title).disposed(by: disposeBag)
    }
    
}

//  MARK: - Extension - CreditListViewController: UITableViewDelegate
extension CreditListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
