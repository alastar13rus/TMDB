//
//  TVEpisodeDetailViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class TVEpisodeDetailViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: TVEpisodeDetailViewModel!
    let dataSource = TVEpisodeDetailDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    let tvEpisodeDetailTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var appearance = NavigationBarAppearance(barAppearance: .init())
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(tvEpisodeDetailTableView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            tvEpisodeDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tvEpisodeDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tvEpisodeDetailTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tvEpisodeDetailTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}

//  MARK: - BindableType
extension TVEpisodeDetailViewController: BindableType {
    func bindViewModel() {
        tvEpisodeDetailTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.sectionedItems.asDriver(onErrorJustReturn: []).drive(tvEpisodeDetailTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        viewModel.output.title.asDriver(onErrorJustReturn: "").drive(navigationItem.rx.title).disposed(by: disposeBag)
    }
}

extension TVEpisodeDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .tvEpisodeStillWrapper: return tableView.bounds.height
        case .tvEpisodeTrailerButton: return 64
        case .tvEpisodeOverview(let vm): return tableView.calculateCellHeight(withContent: vm.overview, font: .systemFont(ofSize: 16))
        case .tvEpisodeImageList: return tableView.bounds.width * 2 / 3
        case .tvEpisodeCastShortList: return tableView.bounds.width / 2 + 24
        case .tvEpisodeCrewShortList: return tableView.bounds.width / 2 + 24
        case .tvEpisodeGuestStarsShortList: return tableView.bounds.width / 2 + 24
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
