//
//  PeopleShortListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class PeopleShortListTableViewCell: UITableViewCell {
    
// MARK: - Properties
    var viewModel: PeopleShortListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let dataSource = PeopleShortListCollectionViewDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    lazy var peopleShortListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemHeight = 220
        layout.itemSize = .init(width: itemHeight * 2 / 3, height: itemHeight)
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PeopleCollectionViewCell.self,
                                forCellWithReuseIdentifier: PeopleCollectionViewCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
// MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Methods
    
    fileprivate func setupUI() {
        backgroundColor = .systemGreen
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(peopleShortListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            peopleShortListCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            peopleShortListCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            peopleShortListCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            peopleShortListCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    fileprivate func configure(with vm: PeopleShortListViewModel) {
        vm.output.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(peopleShortListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        peopleShortListCollectionView.rx
            .modelSelected(PeopleCellViewModel.self).map { $0.id }
            .bind(to: vm.input.selectedItem)
            .disposed(by: disposeBag)
        
    }
}
