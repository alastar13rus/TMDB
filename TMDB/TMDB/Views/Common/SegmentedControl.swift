//
//  SegmentedControl.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 06.04.2021.
//

import UIKit

class SegmentedControl: UISegmentedControl {
    
    convenience init() {
        self.init(frame: CGRect())

        self.selectedSegmentIndex = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
