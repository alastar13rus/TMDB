//
//  ViewModelType.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.03.2021.
//

import Foundation

protocol ViewModelType: class {
    
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    var coordinator: Coordinator? { get set }

}

protocol GeneralViewModelType: ViewModelType {
    
    init(networkManager: NetworkManagerProtocol)
}

protocol DetailViewModelType: ViewModelType {
    
    init(with detailID: String, networkManager: NetworkManagerProtocol)
}
