//
//  UIViewController+Extensions.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import UIKit

extension UIViewController {
    
    func setupNavigationWithAppearance(_ appearance: UINavigationBarAppearance) {
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.largeTitleDisplayMode = .always
        
        let imgBackArrow = UIImage(named: "back_arrow_32")
        navigationController?.navigationBar.backIndicatorImage = imgBackArrow
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        navigationController?.navigationBar.tintColor = .white
        
    }
}
