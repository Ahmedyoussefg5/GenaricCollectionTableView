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
        tableV.translatesAutoresizingMaskIntoConstraints = false
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
        dataSource = TableViewDataSource(data: data, tableView: mainTableView, heightForRow: 100)
        
        // You Can Change Delegate For Customization
        // mainTableView.dataSource = dataSource
        // mainTableView.delegate = dataSource
        
        dataSource?.cellSelect = { index in
            PhotoServices.shared.getImageFromGalary(on: self, completion: { (img) in
                if let img = img {
                    print(img.size)
                }
            })
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
