//
//  MonitoringUseCase.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 14.06.2021.
//

import Foundation

public protocol MonitoringUseCase {
    
    func activate()
    func checkStatus() -> Bool
}
