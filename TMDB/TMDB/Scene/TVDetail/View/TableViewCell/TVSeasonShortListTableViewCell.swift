//
//  TVSeasonShortListTableViewCell.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 01.05.2021.
//

import UIKit
import RxSwift

class TVSeasonShortListTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var viewModel: TVSeasonShortListViewModel! {
        didSet {
            configure(with: viewModel)
        }
    }
    let dataSource = TVSeasonShortListCollectionViewDataSource.dataSource()
    
    var dataSourceInfo: [(itemsCount: Int, sectionNumber: Int)] {
       
        var dataSourceInfo = [(itemsCount: Int, sectionNumber: Int)]()
        let sectionCount = dataSource.sectionModels.count
        Array(0..<sectionCount).forEach { dataSourceInfo.append((dataSource[$0].items.count, $0)) }
       
        return dataSourceInfo
    }
    let disposeBag = DisposeBag()
    
    lazy var tvSeasonShortListCollectionView: UICollectionView = {
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TVSeasonCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TVSeasonCollectionViewCell.self))
        collectionView.register(ShowMoreCell.self, forCellWithReuseIdentifier: String(describing: ShowMoreCell.self))
        collectionView.backgroundColor = .white
//        collectionView.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
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
    fileprivate func configure(with vm: TVSeasonShortListViewModel) {
        vm.sectionedItems.asDriver(onErrorJustReturn: []).drive(tvSeasonShortListCollectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        tvSeasonShortListCollectionView.rx.modelSelected(TVSeasonCellViewModelMultipleSection.SectionItem.self).bind(to: vm.selectedItem).disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        
    }
    
    fileprivate func setupHierarhy() {
        contentView.addSubview(tvSeasonShortListCollectionView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            tvSeasonShortListCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tvSeasonShortListCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tvSeasonShortListCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tvSeasonShortListCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
}

extension TVSeasonShortListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch dataSource[indexPath] {
        case .season:
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
        
        let indexPath = setupIndexPath(dataSourceInfo: dataSourceInfo, collectionViewContentOffsetX: scrollView.contentOffset.x, collectionViewWidth: (self.bounds.width - 2 * 12) / 3 * 2, factor: factor)
        
        tvSeasonShortListCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func setupIndexPath(dataSourceInfo: [(itemsCount: Int, sectionNumber: Int)], collectionViewContentOffsetX contentOffsetX: CGFloat, collectionViewWidth width: CGFloat, factor: CGFloat) -> IndexPath {
        
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
        case .seasonSection: return 3
        case .showMoreSection: return 1
        }
    }
    
}
