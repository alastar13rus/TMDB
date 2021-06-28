//
//  NetworkMonitorDelegate.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 14.06.2021.
//

import Foundation

public protocol NetworkMonitorDelegate: AnyObject {
    func didChangeStatus(_ isConnected: Bool)
    func inform(with message: String)
}
