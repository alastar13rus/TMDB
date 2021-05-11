//
//  MediaCompilationListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 27.04.2021.
//

import UIKit
import RxSwift
import RxDataSources

class MediaCompilationListTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    let disposeBag = DisposeBag()
    let dataSource = MediaListCollectionViewDataSource.dataSource()
    var viewModel: MediaCompilationListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    
    lazy var mediaCompilationListCollectionView: UICollectionView = {
        let layout = CollectionViewLayout(countItemsInScrollDirection: 3, scrollDirection: .horizontal, contentForm: .portrait, view: self)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MediaCollectionViewCell.self))
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
    fileprivate func configure(with vm: MediaCompilationListViewModel) {
        vm.sectionedItems.asDriver(onErrorJustReturn: []).drive(mediaCompilationListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        mediaCompilationListCollectionView.rx.modelSelected(MediaCellViewModelMultipleSection.SectionItem.self).bind(to: vm.selectedItem).disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(mediaCompilationListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            mediaCompilationListCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mediaCompilationListCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mediaCompilationListCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            mediaCompilationListCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
}
