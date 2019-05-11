//
//  File1.swift
//  Genaric CollectionView Test
//
//  Created by Youssef on 4/30/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

protocol IndexPathIndexable {
    associatedtype ItemType
    
    func objectAtIndexPath(indexPath: IndexPath) -> ItemType
    func numberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
}

extension Array: IndexPathIndexable {
    
    func objectAtIndexPath(indexPath: IndexPath) -> Element {
        return self[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return count
    }
}
