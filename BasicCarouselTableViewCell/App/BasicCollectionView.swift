//
//  BasicCollectionView.swift
//  BasicCarouselTableViewCell
//
//  Created by Stephen Wu on 2/27/19.
//  Copyright © 2019 Stephen Wu. All rights reserved.
//

import Foundation
import UIKit

/// Subclasses UICollectionView to fix some autolayout issues when embedded in a table view cell
class BasicCarouselCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()

        if bounds.size != self.intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }

    }

    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
