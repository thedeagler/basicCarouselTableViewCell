//
//  BasicCarouselTableViewCell.swift
//  BasicCarouselTableViewCell
//
//  Created by Stephen Wu on 2/26/19.
//  Copyright © 2019 Stephen Wu. All rights reserved.
//

import UIKit

/// T
class BasicCarouselTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: BasicCarouselCollectionView!
    @IBOutlet weak var height: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
    }

    func registerCells() {
        collectionView.register(BasicCarouselItemCell.nib(), forCellWithReuseIdentifier: "unit")
    }

    func setCarousel(controller: BasicCarouselController, layout: UICollectionViewFlowLayout) {
        collectionView.collectionViewLayout = layout
        height.constant = layout.itemSize.height + layout.sectionInset.top + layout.sectionInset.bottom
        collectionView.dataSource = controller
        collectionView.delegate = controller
        collectionView.contentOffset = controller.offset ?? .zero
        collectionView.layoutIfNeeded() // Positions the collection view items correctly the first time
        collectionView.reloadData()
    }

    override func prepareForReuse() {
        // Stop scrolling velocity for cell reuse
        collectionView.setContentOffset(collectionView.contentOffset, animated: false)
    }
}
