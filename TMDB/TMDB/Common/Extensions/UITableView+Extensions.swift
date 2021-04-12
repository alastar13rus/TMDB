//
//  UITableView+Extensions.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 09.04.2021.
//

import UIKit

extension UITableView {
    
    func calculateCellHeight(withContent content: String) -> CGFloat {
        let stringSize = CGSize(width: self.bounds.width - 2 * 12, height: .greatestFiniteMagnitude)
        let string = NSAttributedString(string: content, attributes: [.font: UIFont.systemFont(ofSize: 16)])
        let stringBox = string.boundingRect(with: stringSize, options: .usesLineFragmentOrigin, context: nil)
        
        return stringBox.height + 3 * 12
    }
}
