//
//  UICollectionViewFlowLayout+BasicCarousel.swift
//  BasicCarouselTableViewCell
//
//  Created by Stephen Wu on 2/27/19.
//  Copyright © 2019 Stephen Wu. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewFlowLayout {
    private struct Constants {
        static let carouselWidth: CGFloat = UIScreen.main.bounds.width
        static let interItemSpacing: CGFloat = 8
    }

    /// Initializes collection view flow layout object intended for use with a basic carousel
    ///
    /// - Parameters:
    ///   - numItems: the number of items to show on the initial view of the screen
    ///   - verticalPadding: Amount of padding above and below the content
    ///   - horizontalPadding: Amount of padding before and after the content
    ///   - heightForWidth: Optional callback calculating the height of the content given the width of a single item. Uses automatic size if not provided.
    static func createForBasicCarousel(numItems: CGFloat = 2.5, verticalPadding: CGFloat = 0, horizontalPadding: CGFloat = 0, heightForWidth: ((CGFloat) -> CGFloat)?) -> UICollectionViewFlowLayout {

        let itemWidth = (Constants.carouselWidth - (horizontalPadding + Constants.interItemSpacing * floor(numItems))) / numItems
        let layout = UICollectionViewFlowLayout()
        let height: CGFloat? = heightForWidth?(itemWidth)
        layout.itemSize = height.flatMap { CGSize(width: itemWidth, height: $0) } ?? UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = Constants.interItemSpacing
        layout.sectionInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        layout.scrollDirection = .horizontal

        return layout
    }
}
