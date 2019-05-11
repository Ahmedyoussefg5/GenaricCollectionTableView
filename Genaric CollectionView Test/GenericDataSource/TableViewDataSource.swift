//
//  File1.swift
//  Genaric CollectionView Test
//
//  Created by Youssef on 4/30/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

protocol TableViewCellConfigurable {
    associatedtype ItemType
    associatedtype CellType: UITableViewCell
    
    static func reuseIdentifierForIndexPath(indexPath: IndexPath) -> String
    static func configureCellAtIndexPath(indexPath: IndexPath, item: ItemType, cell: CellType)
}

class TableViewDataSource<T: IndexPathIndexable, C: TableViewCellConfigurable>: NSObject, UITableViewDataSource, UITableViewDelegate where T.ItemType == C.ItemType {
    private let data: T
    private var heightForRow: CGFloat
    var cellSelect: ((_ index: Int) -> Void)?

    init(data: T, tableView: UITableView, heightForRow: CGFloat) {
        self.data = data
        self.heightForRow = heightForRow
        super.init()
        tableView.register(C.CellType.self, forCellReuseIdentifier: C.reuseIdentifierForIndexPath(indexPath: IndexPath(item: 0, section: 0)))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("T##items: Any...##Any")
        cellSelect?(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = C.reuseIdentifierForIndexPath(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! C.CellType
        let item = data.objectAtIndexPath(indexPath: indexPath)
        C.configureCellAtIndexPath(indexPath: indexPath, item: item, cell: cell)
        
        return cell
    }
}
