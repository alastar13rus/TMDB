//
//  MediaRecommendationListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 27.04.2021.
//

import UIKit
import RxSwift
import RxDataSources

class MediaRecommendationListTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    let disposeBag = DisposeBag()
    let dataSource = MediaListCollectionViewDataSource.dataSource()
    var viewModel: MediaRecommendationListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    lazy var mediaRecommendationListCollectionView: UICollectionView = {
        let layout = CollectionViewLayout(countItemsInRowOrColumn: 3, scrollDirection: .horizontal, view: self)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MediaCollectionViewCell.self))
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
    fileprivate func configure(with vm: MediaRecommendationListViewModel) {
        vm.sectionedItems.asDriver(onErrorJustReturn: []).drive(mediaRecommendationListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        mediaRecommendationListCollectionView.rx.modelSelected(MediaCellViewModelMultipleSection.SectionItem.self).subscribe(onNext: { (item) in
            print(item)
        }).disposed(by: disposeBag)
        
        mediaRecommendationListCollectionView.rx.modelSelected(MediaCellViewModelMultipleSection.SectionItem.self).bind(to: vm.selectedItem).disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(mediaRecommendationListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            mediaRecommendationListCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mediaRecommendationListCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mediaRecommendationListCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            mediaRecommendationListCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
}
