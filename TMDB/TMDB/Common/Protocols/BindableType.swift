//
//  BindableType.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.03.2021.
//

import UIKit

protocol BindableType: AnyObject {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    init()
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bindViewModel(to model: ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
