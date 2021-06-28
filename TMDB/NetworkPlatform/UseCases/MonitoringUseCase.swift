//
//  MonitoringUseCase.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 14.06.2021.
//

import Foundation
import Domain

class MonitoringUseCase: Domain.MonitoringUseCase {
    
    func activate() {
        let monitor = NetworkMonitor.shared
//        monitor.delegate = delegate
        monitor.start()
    }
    
    func checkStatus() -> Bool {
        let monitor = NetworkMonitor.shared
        return monitor.isConnected
    }
    
}
