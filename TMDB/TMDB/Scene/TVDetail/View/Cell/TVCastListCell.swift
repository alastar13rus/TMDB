//
//  TVCastListCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class TVCastListCell: UITableViewCell {
    
//    MARK: - Properties
    let disposeBag = DisposeBag()
    let dataSource = TVCastListDataSource.dataSource()
    var viewModel: TVCastListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    lazy var tvCastListCollectionView: TVCastListCollectionView = {
        let collectionView = TVCastListCollectionView(frame: .zero, collectionViewLayout: TVCollectionViewLayout(countItemsInRowOrColumn: 3, scrollDirection: .horizontal, view: self))
        collectionView.register(TVCastCell.self, forCellWithReuseIdentifier: String(describing: TVCastCell.self))
        collectionView.register(ShowMoreCell.self, forCellWithReuseIdentifier: String(describing: ShowMoreCell.self))
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
    fileprivate func configure(with vm: TVCastListViewModel) {
        vm.sectionedItems.map { (sections) -> [TVCastCellViewModelSection] in
            sections.map {
                $0.items.append(TVCastCellViewModel($0.items.last!))
                return $0
            }
        }
        .asDriver(onErrorJustReturn: []).drive(tvCastListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(tvCastListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            tvCastListCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tvCastListCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tvCastListCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tvCastListCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
}
