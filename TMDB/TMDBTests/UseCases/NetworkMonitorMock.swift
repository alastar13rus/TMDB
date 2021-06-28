//
//  NetworkMonitorMock.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 28.06.2021.
//

import Foundation
import Network
import Domain
@testable import TMDB

class NetworkMonitorMock: Domain.NetworkMonitor {
    
    var delegate: NetworkMonitorDelegate?
    
    var monitor: NWPathMonitor
    
    var isConnected: Bool = true

    private init() {
        self.monitor = NWPathMonitor()
    }
    
    static var shared: Domain.NetworkMonitor = NetworkMonitorMock()
    
    func start() {
        
    }
    
    func stop() {
        
    }
    
    
    
    
}
