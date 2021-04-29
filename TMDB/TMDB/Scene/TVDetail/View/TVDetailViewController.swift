//
//  TVDetailViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 08.04.2021.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class TVDetailViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: TVDetailViewModel!
    let dataSource = TVDetailDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    let tvDetailTableView: MediaDetailTableView = {
        let tableView = MediaDetailTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    
    lazy var appearance = NavigationBarAppearance(barAppearance: .init())
    
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.subviews.forEach { $0.clipsToBounds = true }
    }
    
//    MARK: - Methods
    private func setupUI() {
        setupNavigationWithAppearance(appearance)
    }
    
    private func setupHierarhy() {
        view.addSubview(tvDetailTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tvDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tvDetailTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tvDetailTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tvDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension TVDetailViewController: BindableType {
    
    func bindViewModel() {
        
        tvDetailTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.sectionedItems.asDriver(onErrorJustReturn: []).drive(tvDetailTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        viewModel.output.title.asDriver(onErrorJustReturn: "").drive(navigationItem.rx.title).disposed(by: disposeBag)
        
        viewModel.output.backdropImageData.skip(1).subscribe(onNext: { (imageData) in
            self.navigationItem.standardAppearance?.backgroundColor = .white
            
            guard let imageData = imageData else {
                self.navigationItem.scrollEdgeAppearance?.backgroundColor = .white
                self.navigationItem.compactAppearance?.backgroundColor = .white
                self.navigationItem.scrollEdgeAppearance?.largeTitleTextAttributes = [
                    .foregroundColor: UIColor.darkText,
                    .font: UIFont.boldSystemFont(ofSize: 24),
                ]
                self.navigationItem.compactAppearance?.largeTitleTextAttributes = [
                    .foregroundColor: UIColor.darkText,
                    .font: UIFont.boldSystemFont(ofSize: 24),
                ]
                self.navigationItem.compactAppearance?.backgroundColor = .white
                return
            }
            self.navigationItem.scrollEdgeAppearance?.backgroundImage = UIImage(data: imageData)
            self.navigationItem.compactAppearance?.backgroundImage = UIImage(data: imageData)
        }).disposed(by: disposeBag)
        
    }
}

extension TVDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .tvPosterWrapper: return tableView.bounds.height
        case .tvOverview(let vm): return tableView.calculateCellHeight(withContent: vm.overview, font: .systemFont(ofSize: 16))
        case .tvGenres(let vm): return tableView.calculateCellHeight(withContent: vm.genres, font: .boldSystemFont(ofSize: 14))
        case .tvImageList: return tableView.bounds.width / 3 + 24
        case .tvCastList: return tableView.bounds.width / 2 + 24
        case .tvCrewList: return tableView.bounds.width / 2 + 24
        case .tvCompilationList: return tableView.bounds.width / 2 + 24
        case .tvRuntime, .tvStatus: return 40
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .tvPosterWrapper: return tableView.bounds.height
        case .tvOverview(let vm): return tableView.calculateCellHeight(withContent: vm.overview, font: .systemFont(ofSize: 16))
        case .tvGenres(let vm): return tableView.calculateCellHeight(withContent: vm.genres, font: .boldSystemFont(ofSize: 14))
        case .tvImageList: return tableView.bounds.width / 3 + 24
        case .tvCastList: return tableView.bounds.width / 2 + 24
        case .tvCrewList: return tableView.bounds.width / 2 + 24
        case .tvCompilationList: return tableView.bounds.width / 2 + 24
        case .tvRuntime, .tvStatus: return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource[section] {
        case .tvRuntimeSection,
             .tvGenresSection,
             .tvCastListSection,
             .tvCrewListSection,
             .tvStatusSection,
             .tvCompilationListSection:
            return 40
        default:
            return 0
        }
    }
}
