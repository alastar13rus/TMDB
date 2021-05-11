//
//  MediaTrailerListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import UIKit
import RxSwift
import RxDataSources

class MediaTrailerListViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: MediaTrailerListViewModel!
    let dataSource = MediaTrailerListDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    lazy var mediaTrailerListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.width)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MediaTrailerCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MediaTrailerCollectionViewCell.self))
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    
    
//    MARK: - Methods
    fileprivate func setupUI() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Трейлеры"
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(mediaTrailerListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            mediaTrailerListCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mediaTrailerListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mediaTrailerListCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mediaTrailerListCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    
}

extension MediaTrailerListViewController: BindableType {
    
    func bindViewModel() {
        viewModel.output.sectionedItems.asDriver(onErrorJustReturn: []).drive(mediaTrailerListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
}
