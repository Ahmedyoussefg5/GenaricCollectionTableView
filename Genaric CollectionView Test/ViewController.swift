//
//  ViewController.swift
//  Genaric CollectionView Test
//
//  Created by Youssef on 4/23/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var mainTableView: UITableView = {
        let tableV = UITableView()
        tableV.allowsSelection = false
        tableV.translatesAutoresizingMaskIntoConstraints = false
//        tableV.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifierForIndexPath())
        return tableV
    }()
    
    var dataSource: TableViewDataSource<Array<CustomCellData>, CustomTableViewCell>?

    let data = [
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Hi", detail: "CocoaHeads"),
        CustomCellData(title: "Utah", detail: "Devs Rule!"),
        CustomCellData(title: "Utah", detail: "Devs Rule!"),
        CustomCellData(title: "Utah", detail: "Devs Rule!"),
        CustomCellData(title: "Utah", detail: "Devs Rule!"),
        CustomCellData(title: "Utah", detail: "Devs Rule!"),
        CustomCellData(title: "Utah", detail: "Devs Rule!"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        mainTableView.backgroundColor = .red
        view.addSubview(mainTableView)
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        dataSource = TableViewDataSource(data: data, tableView: mainTableView)
        mainTableView.dataSource = dataSource
        
        dataSource?.cellSelect = { index in
            print(index)
        }
    }
}

struct CustomCellData {
    let title: String
    let detail: String
}

class CustomTableViewCell: UITableViewCell, TableViewCellConfigurable {

    static func reuseIdentifierForIndexPath(indexPath: IndexPath = IndexPath(item: 0, section: 0)) -> String {
        return String(describing: self)
    }
    
    static func configureCellAtIndexPath(indexPath: IndexPath, item: CustomCellData, cell: CustomTableViewCell) {
        cell.textLabel?.text = "asdaa \(indexPath.row)"
        print(indexPath.row)
    }
}
