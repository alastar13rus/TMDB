//
//  CrewShortListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class CrewShortListTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    let disposeBag = DisposeBag()
    let dataSource = CreditShortListDataSource.dataSource()
    var viewModel: CreditShortListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    lazy var crewListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout(countItemsInRowOrColumn: 3, scrollDirection: .horizontal, view: self))
        collectionView.register(CrewCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CrewCollectionViewCell.self))
        collectionView.register(ShowMoreCell.self, forCellWithReuseIdentifier: String(describing: ShowMoreCell.self))
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
    fileprivate func configure(with vm: CreditShortListViewModel) {
        vm.sectionedItems.asDriver(onErrorJustReturn: []).drive(crewListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        crewListCollectionView.rx.modelSelected(CreditCellViewModelMultipleSection.SectionItem.self).bind(to: viewModel.selectedItem).disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(crewListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            crewListCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            crewListCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            crewListCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            crewListCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
}
