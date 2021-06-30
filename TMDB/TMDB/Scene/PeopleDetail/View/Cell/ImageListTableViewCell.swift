//
//  ImageListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.04.2021.
//

import UIKit
import RxSwift
import RxDataSources
import Domain

class ImageListTableViewCell: UITableViewCell {
    
// MARK: - Properties
    var viewModel: ImageListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    var imageType: ImageType?
    let dataSource = ImageListDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    lazy var imageListCollectionView: UICollectionView = { [weak self] in
        guard let self = self else { return UICollectionView() }
        switch self.imageType {
        case .profile:
            let layout = CollectionViewLayout(countItemsInScrollDirection: 3, scrollDirection: .horizontal, contentForm: .portrait, view: self)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
            collectionView.backgroundColor = .white
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        case .backdrop:
            let layout = CollectionViewLayout(countItemsInScrollDirection: 2, scrollDirection: .horizontal, contentForm: .landscape, view: self)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
            collectionView.backgroundColor = .white
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        case .still:
            let layout = CollectionViewLayout(countItemsInScrollDirection: 2, scrollDirection: .horizontal, contentForm: .landscape, view: self)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
            collectionView.backgroundColor = .white
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        default: return UICollectionView()
        }
    }()
    
// MARK: - Init
    
    convenience init(withImageType imageType: ImageType) {
        self.init()
        self.imageType = imageType
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
// MARK: - Methods
    fileprivate func configure(with vm: ImageListViewModel) {
        viewModel.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(imageListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        imageListCollectionView.rx
            .modelSelected(ImageCellViewModel.self)
            .bind(to: vm.selectedItem)
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(imageListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            imageListCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageListCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageListCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            imageListCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
}
