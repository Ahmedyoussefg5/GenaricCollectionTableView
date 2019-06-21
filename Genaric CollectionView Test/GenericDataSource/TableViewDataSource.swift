//
//  File1.swift
//  Genaric CollectionView Test
//
//  Created by Youssef on 4/30/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

//protocol TableViewCellConfigurable {
//    associatedtype ItemType
//    associatedtype CellType: UITableViewCell
//    
////    static func reuseIdentifierForIndexPath(indexPath: IndexPath) -> String
//    static func configureCellAtIndexPath(indexPath: IndexPath, item: ItemType, cell: CellType)
//}

class TableViewDataSource<T: Codable, C: BaseTableViewCell<T>>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private weak var tableView: UITableView?
    
    private let data: [T]
    private var heightForRow: CGFloat?
    
    var cellSelect: ((_ index: Int, _ cell: C?) -> Void)? {
        didSet {
            tableView?.allowsSelection = true
        }
    }
    
    var willDisplayRow: ((_ index: Int) -> Void)?
    
    init(data: [T], tableView: UITableView, heightForRow: CGFloat? = nil) {
        self.data = data
        self.heightForRow = heightForRow
        self.tableView = tableView
        super.init()
        
        tableView.register(C.self, forCellReuseIdentifier: String(describing: C.self))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        if heightForRow == nil {
            tableView.estimatedRowHeight = 100
        }
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cellSelect?(indexPath.row, tableView.cellForRow(at: indexPath) as? C)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: C.self)) as! C
        // let item = data.objectAtIndexPath(indexPath: indexPath)
        
        cell.configCell(data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        willDisplayRow?(indexPath.row)
    }
}
