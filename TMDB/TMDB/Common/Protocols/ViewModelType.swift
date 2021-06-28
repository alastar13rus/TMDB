//
//  ViewModelType.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 16.03.2021.
//

import Foundation
import Swinject

protocol ViewModelType: AnyObject {
    
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    var coordinator: Coordinator? { get set }

}
