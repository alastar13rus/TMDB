//
//  TVSeasonDetailViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 04.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class TVSeasonDetailViewController: UIViewController {
    
// MARK: - Properties
    var viewModel: TVSeasonDetailViewModel!
    let dataSource = TVSeasonDetailDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    let tvSeasonDetailTableView: UITableView = {
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(tvSeasonDetailTableView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            tvSeasonDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tvSeasonDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tvSeasonDetailTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tvSeasonDetailTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

// MARK: - BindableType
extension TVSeasonDetailViewController: BindableType {
    func bindViewModel() {
        tvSeasonDetailTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(tvSeasonDetailTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tvSeasonDetailTableView.rx
            .modelSelected(TVSeasonDetailCellViewModelMultipleSection.SectionItem.self)
            .bind(to: viewModel.input.selectedItem).disposed(by: disposeBag)
        
        viewModel.output.title
            .asDriver(onErrorJustReturn: "")
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}

extension TVSeasonDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .tvSeasonPosterWrapper:
            return tableView.bounds.height
        case .tvSeasonTrailerButton: return 64
        case .tvSeasonOverview(let vm): return tableView.calculateCellHeight(withContent: vm.overview, font: .systemFont(ofSize: 16))
        case .tvSeasonImageList: return tableView.bounds.width / 3 + 24
        case .tvSeasonCastShortList: return tableView.bounds.width / 2 + 24
        case .tvSeasonCrewShortList: return tableView.bounds.width / 2 + 24
        case .tvEpisodeShortList: return 200
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
