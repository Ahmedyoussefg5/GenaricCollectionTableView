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
    let data: T
    var cellSelect: ((_ index: Int) -> Void)?

    init(data: T, tableView: UITableView) {
        self.data = data
        tableView.register(C.CellType.self, forCellReuseIdentifier: C.reuseIdentifierForIndexPath(indexPath: IndexPath(item: 0, section: 0)))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellSelect?(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = C.reuseIdentifierForIndexPath(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? C.CellType else {
            fatalError("Cells with reuse identifier \(reuseIdentifier) not of type \(C.CellType.self)")
        }
        let item = data.objectAtIndexPath(indexPath: indexPath)
        C.configureCellAtIndexPath(indexPath: indexPath, item: item, cell: cell)
        return cell
    }
}
