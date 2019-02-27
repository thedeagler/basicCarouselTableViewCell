//
//  Row+example.swift
//  BasicCarouselTableViewCell
//
//  Created by Stephen Wu on 2/27/19.
//  Copyright © 2019 Stephen Wu. All rights reserved.
//

import Foundation
import UIKit

enum Row {
    case normal
    case carousel(BasicCarouselViewModel)
}


extension Row {
    static func createExampleRows() -> [Row] {
        let layout = UICollectionViewFlowLayout.createForBasicCarousel(numItems: 3.75, verticalPadding: ViewController.Constants.verticalPadding, horizontalPadding: ViewController.Constants.horizontalPadding) { (width) -> CGFloat in
            return width * ViewController.Constants.aspectRatio
        }
        let vm = BasicCarouselViewModel(items: BasicCarouselViewModel.createViews(numViews: 40), layout: layout)

        let layout2 = UICollectionViewFlowLayout.createForBasicCarousel(numItems: 5.5, verticalPadding: ViewController.Constants.verticalPadding, horizontalPadding: ViewController.Constants.horizontalPadding) { (width) -> CGFloat in
            return width * ViewController.Constants.aspectRatio
        }
        let vm2 = BasicCarouselViewModel(items: BasicCarouselViewModel.createViews(numViews: 20), layout: layout2)

        let layout3 = UICollectionViewFlowLayout.createForBasicCarousel(numItems: 2.15, verticalPadding: ViewController.Constants.verticalPadding, horizontalPadding: ViewController.Constants.horizontalPadding) { (width) -> CGFloat in
            return width * ViewController.Constants.aspectRatio
        }
        let vm3 = BasicCarouselViewModel(items: BasicCarouselViewModel.createViews(numViews: 10), layout: layout3)
        return [
            .normal,
            .normal,
            .carousel(vm),
            .normal,
            .normal,
            .normal,
            .carousel(vm2),
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .normal,
            .carousel(vm3),
            .normal,
            .normal,
            .normal,
            .normal
        ]
    }
}
