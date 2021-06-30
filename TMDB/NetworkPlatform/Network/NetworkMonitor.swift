//
//  NetworkMonitor.swift
//  NetworkPlatform
//
//  Created by Докин Андрей (IOS) on 13.06.2021.
//

import UIKit
import Foundation
import Domain
import Network

public class NetworkMonitor: Domain.NetworkMonitor {
    
    public weak var delegate: NetworkMonitorDelegate?
    public let monitor: NWPathMonitor
    public var isConnected = true {
        didSet {
            guard isConnected != oldValue else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self, let delegate = self.delegate else { return }
                delegate.didChangeStatus(self.isConnected)
            }
        }
    }
    
    public static let shared: Domain.NetworkMonitor = NetworkMonitor()
    
    private init() {
        self.monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] (path) in
            if case .satisfied = path.status {
                self?.isConnected = true
            } else {
                self?.isConnected = false
            }
        }
    }
    
    public func start() {
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    
    public func stop() {
        monitor.cancel()
    }
    
}
