//
//  MovieListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.03.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MovieListViewController: UIViewController {
    
//    MARK: - Property
    var viewModel: MovieListViewModel!
    var disposeBag = DisposeBag()
    var movieListDataSource = MovieListDataSource.dataSource()
    
    var categoryListSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    var movieListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemBlue
        tableView.separatorInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        tableView.tableFooterView = UIView()
        let refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.endRefreshing()
            refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
            return refreshControl
        }()
        tableView.refreshControl = refreshControl
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
    private func setupUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func setupHierarhy() {
        view.addSubview(categoryListSegmentedControl)
        view.addSubview(movieListTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryListSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryListSegmentedControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            categoryListSegmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            categoryListSegmentedControl.heightAnchor.constraint(equalToConstant: 50),
            
            movieListTableView.topAnchor.constraint(equalTo: categoryListSegmentedControl.bottomAnchor),
            movieListTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            movieListTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            movieListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func pullToRefresh(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        viewModel.input.isRefreshing.accept(sender.isRefreshing)
    }
    

}

//  MARK: - Extensions
extension MovieListViewController: BindableType {

    func bindViewModel() {
        viewModel.output.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.output.categories.subscribe(onNext: { (categories) in
            _ = categories.reversed()
                .map { self.categoryListSegmentedControl.insertSegment(withTitle: $0, at: 0, animated: true) }
        }).disposed(by: disposeBag)
        
        movieListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(movieListTableView.rx.items(dataSource: movieListDataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.selectedSegmentIndex
            .asDriver().drive(categoryListSegmentedControl.rx.selectedSegmentIndex)
            .disposed(by: disposeBag)

        viewModel.output.isRefreshing.filter { !$0 } .subscribe (onNext: { _ in
            self.movieListTableView.refreshControl!.endRefreshing()
        }).disposed(by: disposeBag)

        categoryListSegmentedControl.rx.selectedSegmentIndex
            .asDriver().drive(viewModel.input.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        viewModel.output.selectedSegmentIndex.map { _ in true }
            .subscribe(onNext: {  self.movieListTableView.scrollsToTop = $0 })
            .disposed(by: disposeBag)
        
        movieListTableView.rx.willDisplayCell.map { $0.indexPath.row }.bind(to: viewModel.input.willDisplayCellIndex).disposed(by: disposeBag)
                
    }


}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

    
}
