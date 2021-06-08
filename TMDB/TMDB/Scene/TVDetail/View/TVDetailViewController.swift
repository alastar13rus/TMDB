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
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "favoriteEmpty").withTintColor(.white), for: .normal)
        return button
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
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
        
        tvDetailTableView.rx.modelSelected(TVDetailCellViewModelMultipleSection.SectionItem.self)
            .filter { if case .tvTrailerButton = $0 { return true } else { return false } }
            .bind(to: viewModel.input.selectedItem).disposed(by: disposeBag)
        
        tvDetailTableView.rx
            .modelSelected(TVDetailCellViewModelMultipleSection.SectionItem.self)
            .filter { if case .tvTrailerButton = $0 { return true } else { return false } }
            .bind(to: viewModel.input.selectedItem).disposed(by: disposeBag)
        
        favoriteButton.rx.tap
            .bind(to: viewModel.input.toggleFavoriteStatus)
            .disposed(by: disposeBag)
        
        viewModel.output.isFavorite
            .map {
                $0 ?
                    #imageLiteral(resourceName: "favoriteFilled").withTintColor(.systemOrange):
                    #imageLiteral(resourceName: "favoriteEmpty").withTintColor(.systemBlue) }
            .subscribe(onNext: {
                self.favoriteButton.setImage($0, for: .normal)
            })
            .disposed(by: disposeBag)
    }
}

extension TVDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .tvPosterWrapper:
            return tableView.bounds.height
        case .tvTrailerButton: return 64
        case .tvOverview(let vm): return tableView.calculateCellHeight(withContent: vm.overview, font: .systemFont(ofSize: 16))
        case .tvGenres(let vm): return tableView.calculateCellHeight(withContent: vm.genres, font: .boldSystemFont(ofSize: 14))
        case .tvImageList: return tableView.bounds.width / 3 + 24
        case .tvCastShortList: return tableView.bounds.width / 2 + 24
        case .tvCrewShortList: return tableView.bounds.width / 2 + 24
        case .tvSeasonShortList: return 200
        case .tvCompilationList: return tableView.bounds.width / 2 + 24
        case .tvRuntime, .tvStatus: return 40
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource[section] {
        case .tvRuntimeSection,
             .tvGenresSection,
             .tvCastShortListSection,
             .tvCrewShortListSection,
             .tvSeasonShortListSection,
             .tvStatusSection,
             .tvCompilationListSection:
            return 40
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch dataSource[section] {
        case .tvSeasonShortListSection(let title, _):
            let headerView = TVSeasonShortListSectionHeaderView(title: title, numberOfSeasons: viewModel.output.numberOfSeasons.value)
            headerView.showTVSeasonListButtonPressed.rx.tap.map { _ in () }.bind(to: viewModel.input.showTVSeasonListButtonPressed).disposed(by: disposeBag)
            return headerView
        default:
            return nil
        }
    }
}
