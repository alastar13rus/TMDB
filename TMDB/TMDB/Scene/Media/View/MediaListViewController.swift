//
//  MediaListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.03.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MediaListViewController: UIViewController {
    
    // MARK: - Property
    var viewModel: MediaListViewModel!
    private let disposeBag = DisposeBag()
    let dataSource = MediaListTableViewDataSource.dataSource()
    private let categoryListSegmentedControl = SegmentedControl()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    private(set) lazy var mediaListTableView: MediaListTableView = {
        let tableView = MediaListTableView(cellType: MediaTableViewCell.self, refreshControl: refreshControl)
        return tableView
    }()
    
    private var customActivityIndicator: CustomActivityIndicator = {
        let view = CustomActivityIndicator(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.setFillColor(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        view.setStrokeColor(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        setupUI()
        setupHierarhy()
        setupConstraints()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        customActivityIndicator.isHidden = true
        mediaListTableView.refreshControl?.isHidden = true
    }
        
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        
    }
    
    private func setupHierarhy() {
        view.addSubview(categoryListSegmentedControl)
        view.addSubview(mediaListTableView)
        view.addSubview(customActivityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryListSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryListSegmentedControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            categoryListSegmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            categoryListSegmentedControl.heightAnchor.constraint(equalToConstant: 50),
            
            mediaListTableView.topAnchor.constraint(equalTo: categoryListSegmentedControl.bottomAnchor),
            mediaListTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mediaListTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mediaListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            customActivityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            customActivityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
}

// MARK: - Extensions
extension MediaListViewController: BindableType {

    func bindViewModel() {
        viewModel.output.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.output.categories.subscribe(onNext: { (categories) in
            _ = categories.reversed()
                .map { self.categoryListSegmentedControl.insertSegment(withTitle: $0, at: 0, animated: true) }
        }).disposed(by: disposeBag)
        
        mediaListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(mediaListTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.selectedSegmentIndex
            .asDriver().drive(categoryListSegmentedControl.rx.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        categoryListSegmentedControl.rx.selectedSegmentIndex
            .asDriver().drive(viewModel.input.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        mediaListTableView.rx.willDisplayCell
            .observeOn(MainScheduler.asyncInstance)
            .filter { $0.indexPath.row == self.dataSource[$0.indexPath.section].items.count - 1 }
            .subscribeOn(MainScheduler.instance)
            .map { _ in Void() }
            .bind(to: viewModel.input.loadNextPageTrigger)
            .disposed(by: disposeBag)
            
        mediaListTableView.rx
            .modelSelected(MediaCellViewModelMultipleSection.SectionItem.self)
            .bind(to: viewModel.input.selectedMedia).disposed(by: disposeBag)
        
        viewModel.output.isFetching
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.output.isFetching.subscribe(onNext: { [weak self] (isFetching) in
            isFetching ?
                self?.customActivityIndicator.startAnimate([.move, .rotate]):
                self?.customActivityIndicator.stopAnimate()
        }).disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.refreshItemsTrigger)
            .disposed(by: disposeBag)
                
    }

}

extension MediaListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

//extension MediaListViewController: NetworkMonitorDelegate {
//    func didChangeStatus(_ completion: @escaping (Bool) -> Void) {
//        <#code#>
//    }
//}
