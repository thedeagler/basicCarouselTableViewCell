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

struct BasicCarouselViewModel {

    struct Constants {
        static let carouselWidth: CGFloat = UIScreen.main.bounds.width
        static let interItemSpacing: CGFloat = 8
    }

    let views: [CarouselItemType]
    let layout: UICollectionViewFlowLayout

    /// Initializes a basic carousel view model object
    ///
    /// - Parameter numItems: the number of items to show on the initial view of the screen
    init(numItems: CGFloat = 2.5, verticalPadding: CGFloat = 0, horizontalPadding: CGFloat = 0, heightForWidth: ((CGFloat) -> CGFloat)?) {
        let itemWidth = (Constants.carouselWidth - (horizontalPadding + Constants.interItemSpacing * floor(numItems))) / numItems
        let layout = UICollectionViewFlowLayout()
        let height: CGFloat? = heightForWidth?(itemWidth)
        layout.itemSize = height.flatMap { CGSize(width: itemWidth, height: $0) } ?? UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = Constants.interItemSpacing
        layout.sectionInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        layout.scrollDirection = .horizontal

        let INCREMENT: CGFloat = 0.05

        let colors = stride(from: 0, to: 1, by: INCREMENT).map {
            return UIColor(hue: $0, saturation: 1, brightness: 1, alpha: 1)
        }

        let views: [UIView] = colors.map {
            let view = UIView()
            view.backgroundColor = $0
            return view
        }

        self.init(views: views, layout: layout)
    }

    init(views: [CarouselItemType], layout: UICollectionViewFlowLayout) {
        self.views = views
        self.layout = layout
    }
}

/// The carousel controller holds the data and is the datasource
class BasicCarouselController: NSObject {
    let items: [CarouselItemType]
    var offset: CGPoint?

    init(items: [CarouselItemType]) {
        self.items = items
    }

    deinit {
        print("deinit")
    }
}

extension BasicCarouselController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unit", for: indexPath) as! BasicCarouselUnitCollectionViewCell

//        cell.view.backgroundColor = item
        cell.view.constrainEdges(of: item)
        return cell
    }
}

extension BasicCarouselController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offset = scrollView.contentOffset
    }
}
