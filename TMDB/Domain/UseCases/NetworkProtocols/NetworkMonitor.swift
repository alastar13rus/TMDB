//
//  NetworkMonitor.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 28.06.2021.
//

import Foundation
import Network

public protocol NetworkMonitor: AnyObject {
    
    var delegate: NetworkMonitorDelegate? { get set }
    var monitor: NWPathMonitor { get }
    var isConnected: Bool { get }
    
    static var shared: NetworkMonitor { get }
    
    func start()
    func stop()
}

