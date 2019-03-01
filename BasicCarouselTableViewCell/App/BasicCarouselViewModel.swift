//
//  BasicCarouselViewModel.swift
//  BasicCarouselTableViewCell
//
//  Created by Stephen Wu on 2/26/19.
//  Copyright © 2019 Stephen Wu. All rights reserved.
//

import Foundation
import UIKit

typealias CarouselItemType = UIView

/// Shuttles the data required to present the carousel content
struct BasicCarouselViewModel {

    /// The items which will ultimately be passed to the controller for presentation
    let items: [CarouselItemType]

    /// Defines the layout of the carousel
    let layout: UICollectionViewFlowLayout

    /// Initializes a basic carousel view model object
    ///
    /// - Parameters:
    ///   - items: The items which will ultimately be passed to the controller for presentation
    ///   - layout: The layout object which defines how items in the carousel are positioned
    init(items: [CarouselItemType], layout: UICollectionViewFlowLayout) {
        self.items = items
        self.layout = layout
    }

    private struct Constants {
        static let carouselWidth: CGFloat = UIScreen.main.bounds.width
        static let interItemSpacing: CGFloat = 8
    }



    /// This assumes scale to fill the collection view item
    init(items: [CarouselItemType], numItems: CGFloat = 2.5, verticalPadding: CGFloat = 0, horizontalPadding: CGFloat = 0) {

        self.items = items
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (Constants.carouselWidth - (horizontalPadding + Constants.interItemSpacing * floor(numItems))) / numItems

        var naturalSize: CGSize?
        if let item = items.first {
            naturalSize = item.frame.size
            let hasIntrinsicContentSize = item.intrinsicContentSize != CGSize(width: -1, height: -1)
            if hasIntrinsicContentSize {
                naturalSize = item.intrinsicContentSize
            }
        }

        if let size = naturalSize {
            let scaleRatio = itemWidth / size.width
            let itemHeight = size.height * scaleRatio

            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        } else {
            layout.itemSize = CGSize(width: itemWidth, height: UICollectionViewFlowLayout.automaticSize.height)
        }

        layout.minimumInteritemSpacing = Constants.interItemSpacing
        layout.sectionInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        layout.scrollDirection = .horizontal

        self.layout = layout
    }


    /// This just creates some mock views
    static func createViews(numViews: Int) -> [UIView] {
        let increment: CGFloat = 1 / CGFloat(numViews)

        let colors = stride(from: 0, to: 1, by: increment).map {
            return UIColor(hue: $0, saturation: 1, brightness: 1, alpha: 1)
        }

        let views: [UIView] = colors.map {
            let frame = CGRect(x: 0, y: 0, width: 5, height: 4)
            let view = UIView(frame: frame)
            view.backgroundColor = $0
            return view
        }

        return views
    }
}

/// The carousel controller holds the data and is the datasource.
/// Note: There's an opportunity to genericize this to use any type of item, given a delegate which configures the item within the view.
class BasicCarouselController: NSObject {
    /// The items to show in the carousel
    private let items: [CarouselItemType]

    /// The scroll offset of the carousel. Useful for presnting multiple carousels in views with view recycling such as table/collection views
    var offset: CGPoint?

    /// Initializes the Basic Carousel Controller
    ///
    /// - Parameter items: the items to show in the carousel
    init(items: [CarouselItemType]) {
        self.items = items
    }
}

extension BasicCarouselController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unit", for: indexPath) as! BasicCarouselItemCell
        cell.view.constrainEdges(of: item)
        return cell
    }
}

extension BasicCarouselController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == self else { return } // Theres a bug here which isnt persisting now. gotta double chceck this identity check
        offset = scrollView.contentOffset // Maintains the scroll position of the collection view for cell reuse.
    }
}
