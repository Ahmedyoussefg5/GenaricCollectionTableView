//
//  File1.swift
//  Genaric CollectionView Test
//
//  Created by Youssef on 4/30/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

//protocol CollectionViewCellConfigurable {
//    associatedtype ItemType
//    associatedtype CellType: UICollectionViewCell
//    
//    static func reuseIdentifierForIndexPath(indexPath: IndexPath) -> String
//    static func configureCellAtIndexPath(indexPath: IndexPath, item: ItemType, cell: CellType)
//}

class CollectionViewDataSource<T: Codable, C: BaseCollectionViewCell<T>>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let data: [T]
    
    var cellSelect: ((_ index: Int) -> Void)?

    init(data: [T]) {
        self.data = data
        super.init()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelect?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: C.self, for: indexPath)
        let item = data[indexPath.row]
        cell.configCell(item)
        return cell
    }
}
