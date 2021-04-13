//
//  CastListCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.04.2021.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class CastListCell: UITableViewCell {
    
//    MARK: - Properties
    let disposeBag = DisposeBag()
    let dataSource = CastListDataSource.dataSource()
    var viewModel: CastListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    lazy var castListCollectionView: CastAndCrewListCollectionView = {
        let collectionView = CastAndCrewListCollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout(countItemsInRowOrColumn: 3, scrollDirection: .horizontal, view: self))
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: String(describing: CastCell.self))
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
    fileprivate func configure(with vm: CastListViewModel) {
        vm.sectionedItems.map { (sections) -> [CastCellViewModelSection] in
            sections.map {
                $0.items.append(CastCellViewModel($0.items.last!))
                return $0
            }
        }
        .asDriver(onErrorJustReturn: []).drive(castListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
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
}
