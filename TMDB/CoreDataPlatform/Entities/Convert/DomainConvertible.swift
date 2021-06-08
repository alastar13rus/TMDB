//
//  DomainConvertible.swift
//  CoreDataPlatform
//
//  Created by Докин Андрей (IOS) on 03.06.2021.
//

import Foundation

public protocol DomainConvertible {
    associatedtype DomainType

    func asDomain() -> DomainType
    
    
    
}
