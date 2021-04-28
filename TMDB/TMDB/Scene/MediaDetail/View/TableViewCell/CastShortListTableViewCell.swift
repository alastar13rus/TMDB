//
//  CastShortListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class CastShortListTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    let disposeBag = DisposeBag()
    let dataSource = CreditShortListDataSource.dataSource()
    var viewModel: CreditShortListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    lazy var castListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout(countItemsInScrollDirection: 3, scrollDirection: .horizontal, contentForm: .portrait, view: self))
        collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CastCollectionViewCell.self))
        collectionView.register(ShowMoreCell.self, forCellWithReuseIdentifier: String(describing: ShowMoreCell.self))
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
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
    fileprivate func configure(with vm: CreditShortListViewModel) {
        
        vm.sectionedItems.asDriver(onErrorJustReturn: []).drive(castListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        castListCollectionView.rx.modelSelected(CreditCellViewModelMultipleSection.SectionItem.self).bind(to: viewModel.selectedItem).disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(castListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            castListCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            castListCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            castListCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            castListCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
    
    fileprivate func bindViewModel() {
        
    }
}

extension CastShortListTableViewCell: UICollectionViewDelegate { }
