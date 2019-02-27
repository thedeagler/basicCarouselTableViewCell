//
//  ViewController.swift
//  BasicCarouselTableViewCell
//
//  Created by Stephen Wu on 2/26/19.
//  Copyright © 2019 Stephen Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var rows: [Row] = []
    var carouselControllers: [IndexPath: BasicCarouselController] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        registerCells()

        showRows()

    }

    func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(BasicCarouselTableViewCell.nib(), forCellReuseIdentifier: "carousel")
    }

    struct Constants {
        static let aspectRatio: CGFloat = 0.53
        static let horizontalPadding: CGFloat = 24
        static let verticalPadding: CGFloat = 12
    }

    func showRows() {

        let vm = BasicCarouselViewModel(numItems: 3.75, verticalPadding: Constants.verticalPadding, horizontalPadding: Constants.horizontalPadding) { (width) -> CGFloat in
            return width * Constants.aspectRatio
        }

        let vm2 = BasicCarouselViewModel(numItems: 3.75, verticalPadding: Constants.verticalPadding, horizontalPadding: Constants.horizontalPadding) { (width) -> CGFloat in
            return width * Constants.aspectRatio
        }

        let vm3 = BasicCarouselViewModel(numItems: 3.75, verticalPadding: Constants.verticalPadding, horizontalPadding: Constants.horizontalPadding) { (width) -> CGFloat in
            return width * Constants.aspectRatio
        }
        rows = [
            .normal,
            .normal,
            .carousel(vm),
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
            .normal,
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
            let controller = carouselControllers[indexPath] ?? BasicCarouselController(items: vm.views)
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
