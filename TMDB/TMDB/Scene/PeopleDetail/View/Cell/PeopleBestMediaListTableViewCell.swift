//
//  PeopleBestMediaListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import UIKit
import RxSwift
import RxDataSources

class PeopleBestMediaListTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: PeopleBestMediaListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    let dataSource = BestCreditInMediaListDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    lazy var creditInMediaListCollectionView: UICollectionView = {
        let layout = CollectionViewLayout(countItemsInScrollDirection: 3, scrollDirection: .horizontal, contentForm: .portrait, view: self)
        layout.headerReferenceSize.width = 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CreditInMediaCell.self, forCellWithReuseIdentifier: String(describing: CreditInMediaCell.self))
        collectionView.register(ReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ReusableHeaderView.self))
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
    fileprivate func configure(with vm: PeopleBestMediaListViewModel) {
        viewModel.sectionedItems.asDriver(onErrorJustReturn: []).drive(creditInMediaListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        creditInMediaListCollectionView.rx.modelSelected(CreditInMediaCellViewModelMultipleSection.SectionItem.self).bind(to: viewModel.selectedCredit).disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(creditInMediaListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            creditInMediaListCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            creditInMediaListCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            creditInMediaListCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            creditInMediaListCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
}
