//
//  CrewListCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class CrewListCell: UITableViewCell {
    
//    MARK: - Properties
    let disposeBag = DisposeBag()
    let dataSource = CrewListDataSource.dataSource()
    var viewModel: CrewListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    lazy var crewListCollectionView: CastAndCrewListCollectionView = {
        let collectionView = CastAndCrewListCollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout(countItemsInRowOrColumn: 3, scrollDirection: .horizontal, view: self))
        collectionView.register(CrewCell.self, forCellWithReuseIdentifier: String(describing: CrewCell.self))
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
    fileprivate func configure(with vm: CrewListViewModel) {
        vm.sectionedItems.map { (sections) -> [CrewCellViewModelSection] in
            sections.map {
                $0.items.append(CrewCellViewModel($0.items.last!))
                return $0
            }
        }
        .asDriver(onErrorJustReturn: []).drive(crewListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
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
