//
//  PeopleImageListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import UIKit
import RxSwift
import RxDataSources

class PeopleImageListTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: PeopleImageListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    let dataSource = PeopleImageListDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    lazy var peopleImageListCollectionView: UICollectionView = {
        let layout = CollectionViewLayout(countItemsInRowOrColumn: 3, scrollDirection: .horizontal, view: self)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PeopleImageCell.self, forCellWithReuseIdentifier: String(describing: PeopleImageCell.self))
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
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
    fileprivate func configure(with vm: PeopleImageListViewModel) {
        viewModel.sectionedItems.asDriver(onErrorJustReturn: []).drive(peopleImageListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(peopleImageListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            peopleImageListCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            peopleImageListCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            peopleImageListCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            peopleImageListCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    
}
