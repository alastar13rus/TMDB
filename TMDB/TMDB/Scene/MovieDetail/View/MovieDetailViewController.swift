//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 12.04.2021.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class MovieDetailViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: MovieDetailViewModel!
    let dataSource = MovieDetailDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    let movieDetailTableView: MediaDetailTableView = {
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
        view.addSubview(movieDetailTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieDetailTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            movieDetailTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            movieDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension MovieDetailViewController: BindableType {
    
    func bindViewModel() {
        
        movieDetailTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.sectionedItems.asDriver(onErrorJustReturn: []).drive(movieDetailTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
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

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .moviePosterWrapper: return tableView.bounds.height
        case .movieOverview(let vm): return tableView.calculateCellHeight(withContent: vm.overview, font: .systemFont(ofSize: 16))
        case .movieGenres(let vm): return tableView.calculateCellHeight(withContent: vm.genres, font: .boldSystemFont(ofSize: 14))
        case .movieCastList, .movieCrewList, .movieRecommendationList: return tableView.bounds.width / 2 + 24
        case .movieRuntime, .movieStatus: return 40
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .moviePosterWrapper: return tableView.bounds.height
        case .movieOverview(let vm): return tableView.calculateCellHeight(withContent: vm.overview, font: .systemFont(ofSize: 16))
        case .movieGenres(let vm): return tableView.calculateCellHeight(withContent: vm.genres, font: .boldSystemFont(ofSize: 14))
        case .movieCastList, .movieCrewList, .movieRecommendationList: return tableView.bounds.width / 2 + 24
        case .movieRuntime, .movieStatus: return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource[section] {
        case .movieRuntimeSection(_, _),
             .movieGenresSection(_, _),
             .movieCreatorsSection(_, _),
             .movieCastListSection(_, _),
             .movieCrewListSection(_, _),
             .movieStatusSection(_, _),
             .movieRecommendationListSection(_, _):
            return 40
        default:
            return 0
        }
    }
}
