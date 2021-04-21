//
//  PeopleDetailViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.04.2021.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class PeopleDetailViewController: UIViewController {
    
//    MARK: - Properties
    var viewModel: PeopleDetailViewModel!
    let dataSource = PeopleDetailDataSource.dataSource()
    let disposeBag = DisposeBag()
    
    var bioSectionType: BioSectionType = .short
    
    lazy var peopleDetailTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
//        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
        
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
    }
    
    fileprivate func setupHierarhy() {
        view.addSubview(peopleDetailTableView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            peopleDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            peopleDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            peopleDetailTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            peopleDetailTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    fileprivate func toggleCell(_ indexPath: IndexPath) {
        switch bioSectionType {
        case .full: bioSectionType = .short
        case .short: bioSectionType = .full
        }
        peopleDetailTableView.beginUpdates()
        peopleDetailTableView.reloadRows(at: [indexPath], with: .automatic)
        peopleDetailTableView.endUpdates()
    }
    
    
}

//MARK: - Extensions
extension PeopleDetailViewController: BindableType {
    
    func bindViewModel() {
        
        peopleDetailTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.sectionedItems.asDriver(onErrorJustReturn: []).drive(peopleDetailTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
                
        peopleDetailTableView.rx.itemSelected.filter {
            switch self.dataSource[$0] {
            case .bio: return true
            default: return false
            } }.subscribe(onNext: { self.toggleCell($0) }).disposed(by: disposeBag)
    }
    
}

extension PeopleDetailViewController: UITableViewDelegate { }

extension PeopleDetailViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .profileWrapper(let vm):
            var cellHeight: CGFloat = 0;
            cellHeight += tableView.calculateCellHeight(withContent: vm.name, font: .boldSystemFont(ofSize: 18))
            cellHeight += tableView.calculateCellHeight(withContent: vm.job, font: .italicSystemFont(ofSize: 14))
            cellHeight += tableView.calculateCellHeight(withContent: vm.placeAndBirthday, font: .systemFont(ofSize: 16))
            if let deathday = vm.deathday {
                cellHeight += tableView.calculateCellHeight(withContent: deathday, font: .systemFont(ofSize: 16))
            }
//            cellHeight += CGFloat(5 * 12)
            return cellHeight > 200 ? cellHeight : 200
        case .imageList: return 200
        case .bio(let vm):
            switch bioSectionType {
            case .full:
                let cellHeight = tableView.calculateCellHeight(withContent: vm.bio, font: .systemFont(ofSize: 16))
                return cellHeight > 200 ? cellHeight : 200
            case .short: return 200
            }
        case .bestMedia: return 200
        case .movie: return 200
        case .tv: return 200
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .profileWrapper: return 200
        case .imageList: return 200
        case .bio(let vm):
            switch bioSectionType {
            case .full:
                let cellHeight = tableView.calculateCellHeight(withContent: vm.bio, font: .systemFont(ofSize: 16))
                return cellHeight > 200 ? cellHeight : 200
            case .short: return 200
            }
        case .bestMedia: return 200
        case .movie: return 200
        case .tv: return 200
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource[section] {
        case .profileWrapperSection: return 0
        case .imageListSection: return 0
        case .bioSection: return 40
        case .bestMediaSection: return 40
        case .movieSection: return 40
        case .tvSection: return 40
        }
    }
    
}

enum BioSectionType {
    case short
    case full
}
