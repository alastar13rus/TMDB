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
        
        viewModel.output.name.asDriver(onErrorJustReturn: "").drive(navigationItem.rx.title).disposed(by: disposeBag)
                
        peopleDetailTableView.rx.itemSelected.filter {
            switch self.dataSource[$0] {
            case .bio: return true
            default: return false
            }
        }.subscribe(onNext: { self.toggleCell($0) }).disposed(by: disposeBag)
        
        peopleDetailTableView.rx.modelSelected(PeopleDetailCellViewModelMultipleSection.SectionItem.self)
            .compactMap { item -> CreditInMediaViewModel? in
                switch item {
                case .cast(let vm): return vm
                case .crew(let vm): return vm
                default: return nil
                }
            }.bind(to: viewModel.input.selectedMedia).disposed(by: disposeBag)
    
    }
}

extension PeopleDetailViewController: UITableViewDelegate { }

extension PeopleDetailViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .profileWrapper(let vm):
            var cellHeight: CGFloat = 0;
            cellHeight += tableView.calculateCellHeightWithImage(withContent: vm.name, font: .boldSystemFont(ofSize: 18))
            cellHeight += tableView.calculateCellHeightWithImage(withContent: vm.job, font: .italicSystemFont(ofSize: 14))
            cellHeight += tableView.calculateCellHeightWithImage(withContent: vm.placeAndBirthdayText, font: .systemFont(ofSize: 16))
            if let deathday = vm.deathdayText {
                cellHeight += tableView.calculateCellHeightWithImage(withContent: deathday, font: .systemFont(ofSize: 16))
            }

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
        case .cast: return 100
        case .crew: return 100
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource[section] {
        case .profileWrapperSection: return 0
        case .imageListSection: return 0
        case .bioSection: return 40
        case .bestMediaSection: return 40
        case .castSection: return 40
        case .crewSection: return 40
        }
    }
    
}

enum BioSectionType {
    case short
    case full
}
