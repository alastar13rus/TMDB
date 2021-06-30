//
//  TVEpisodeShortListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 05.05.2021.
//

import UIKit
import RxSwift

class TVEpisodeShortListTableViewCell: UITableViewCell {
    
// MARK: - Properties
    var viewModel: TVEpisodeShortListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    let dataSource = TVEpisodeShortListCollectionViewDataSource.dataSource()
    
    var dataSourceInfo: [(itemsCount: Int, sectionNumber: Int)] {
       
        var dataSourceInfo = [(itemsCount: Int, sectionNumber: Int)]()
        let sectionCount = dataSource.sectionModels.count
        Array(0..<sectionCount).forEach { dataSourceInfo.append((dataSource[$0].items.count, $0)) }
       
        return dataSourceInfo
    }
    let disposeBag = DisposeBag()
    
    lazy var tvEpisodeShortListCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TVEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: TVEpisodeCollectionViewCell.reuseId)
        collectionView.register(ShowMoreCell.self,
                                forCellWithReuseIdentifier: ShowMoreCell.reuseId)
        collectionView.backgroundColor = .white
//        collectionView.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
// MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Methods
    fileprivate func configure(with vm: TVEpisodeShortListViewModel) {
        vm.sectionedItems
            .asDriver(onErrorJustReturn: [])
            .drive(tvEpisodeShortListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tvEpisodeShortListCollectionView.rx
            .modelSelected(TVEpisodeCellViewModelMultipleSection.SectionItem.self)
            .bind(to: vm.selectedItem)
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(tvEpisodeShortListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            tvEpisodeShortListCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tvEpisodeShortListCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tvEpisodeShortListCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tvEpisodeShortListCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
}

extension TVEpisodeShortListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch dataSource[indexPath] {
        case .episode:
            return CGSize(width: (self.bounds.width - 2 * 12) / 3 * 2, height: (self.bounds.height - 2 * 12 - 2 * 12) / 3)
        case .showMore:
            return CGSize(width: 100, height: (self.frame.height - 2 * 12))
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var factor: CGFloat = 0.5
        if velocity.x < 0 {
            factor = -factor
        }
        
        let indexPath = setupIndexPath(dataSourceInfo: dataSourceInfo,
                                       collectionViewContentOffsetX: scrollView.contentOffset.x,
                                       collectionViewWidth: (self.bounds.width - 2 * 12) / 3 * 2,
                                       factor: factor)
        
        tvEpisodeShortListCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func setupIndexPath(dataSourceInfo: [(itemsCount: Int, sectionNumber: Int)],
                                    collectionViewContentOffsetX contentOffsetX: CGFloat,
                                    collectionViewWidth width: CGFloat,
                                    factor: CGFloat) -> IndexPath {
        
        var accRows = 0
        for tuple in dataSourceInfo {
            let indicativeRow = Int(contentOffsetX / width + factor) * countItemsInColumn(atSection: tuple.sectionNumber)
                
            if tuple.itemsCount + accRows - 1 >= indicativeRow {
                let diff = accRows > 0 ? accRows - tuple.itemsCount : 0
                let itemNumber = (indicativeRow - diff) > 0 ? indicativeRow - diff : 0
                return IndexPath(item: itemNumber, section: tuple.sectionNumber)
            } else {
                accRows += tuple.itemsCount
            }
        }
        return IndexPath(item: 0, section: 0)
    }
    
    fileprivate func countItemsInColumn(atSection section: Int) -> Int {
        switch dataSource[section] {
        case .episodeSection: return 3
        case .showMoreSection: return 1
        }
    }
    
}
