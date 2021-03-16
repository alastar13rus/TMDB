//
//  MovieListViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.03.2021.
//

import UIKit

class MovieListViewController: UIViewController {
    
//    MARK: - Property
    var viewModel: MovieListViewModel!

//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
//    MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        
    }
    
    private func setupHierarhy() {
        
    }
    
    private func setupConstraints() {
        
    }
}

//  MARK: - Extensions
extension MovieListViewController: BindableType {

    func bindViewModel() {
        
    }


}
