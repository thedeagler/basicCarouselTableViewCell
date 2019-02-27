//
//  NibExtensions.swift
//  BasicCarouselTableViewCell
//
//  Created by Stephen Wu on 2/27/19.
//  Copyright © 2019 Stephen Wu. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    @objc class func nib() -> UINib {
        return UINib(nibName: String(describing: self.self), bundle: Bundle(for: self.self))
    }
}

extension UICollectionViewCell {
    @objc class func nib() -> UINib {
        return UINib(nibName: String(describing: self.self), bundle: Bundle(for: self.self))
    }
}

extension UIView {
    @nonobjc func constrainEdges(of view: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0 - insets.right).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0 - insets.bottom).isActive = true
    }
}
