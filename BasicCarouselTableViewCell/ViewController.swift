//
//  ViewController.swift
//  BasicCarouselTableViewCell
//
//  Created by Stephen Wu on 2/26/19.
//  Copyright © 2019 Stephen Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Constants {
        static let aspectRatio: CGFloat = 0.53
        static let horizontalPadding: CGFloat = 24
        static let verticalPadding: CGFloat = 12
    }

    @IBOutlet weak var tableView: UITableView!

    var rows: [Row] = []
    var carouselControllers: [IndexPath: BasicCarouselController] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        registerCells()

        let exampleRows = Row.createExampleRows()
        show(rows: exampleRows)

    }

    func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(BasicCarouselTableViewCell.nib(), forCellReuseIdentifier: "carousel")
    }

    func show(rows: [Row]) {
        self.rows = rows
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        switch row {
        case .normal:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Regular ole cell #\(indexPath.row)"
            return cell

        case .carousel(let vm):
            let cell = tableView.dequeueReusableCell(withIdentifier: "carousel", for: indexPath) as! BasicCarouselTableViewCell
            let controller = carouselControllers[indexPath] ?? BasicCarouselController(items: vm.items)
            carouselControllers[indexPath] = controller
            cell.setCarousel(controller: controller, layout: vm.layout)
            return cell
        }
    }
}

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
