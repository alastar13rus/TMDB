//
//  SearchCategoryListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class SearchCategoryListTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: SearchCategoryListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    let dataSource = SearchCategoryListCollectionViewDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    lazy var searchCategoryListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: self.bounds.width * 3 / 4, height: 48)
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCategoryCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SearchCategoryCollectionViewCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
//    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Methods
    
    fileprivate func setupUI() {
        backgroundColor = .systemRed
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(searchCategoryListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            searchCategoryListCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchCategoryListCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            searchCategoryListCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            searchCategoryListCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
    
    fileprivate func configure(with vm: SearchCategoryListViewModel) {
        vm.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(searchCategoryListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        searchCategoryListCollectionView.rx.modelSelected(SearchCategoryCellViewModel.self).bind(to: vm.input.selectedItem).disposed(by: disposeBag)
    }
}
