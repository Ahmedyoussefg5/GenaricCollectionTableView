//
//  File1.swift
//  Genaric CollectionView Test
//
//  Created by Youssef on 4/30/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

protocol CollectionViewCellConfigurable {
    associatedtype ItemType
    associatedtype CellType: UICollectionViewCell
    
    static func reuseIdentifierForIndexPath(indexPath: IndexPath) -> String
    static func configureCellAtIndexPath(indexPath: IndexPath, item: ItemType, cell: CellType)
}

class CollectionViewDataSource<T: IndexPathIndexable, C: CollectionViewCellConfigurable>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource where T.ItemType == C.ItemType {
    let data: T
    
    var cellSelect: ((_ index: Int) -> Void)?

    init(data: T) {
        self.data = data
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return data.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelect?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = C.reuseIdentifierForIndexPath(indexPath: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? C.CellType else {
            fatalError("Cells with reuse identifier \(reuseIdentifier) not of type \(C.CellType.self)")
        }
        let item = data.objectAtIndexPath(indexPath: indexPath)
        C.configureCellAtIndexPath(indexPath: indexPath, item: item, cell: cell)
        return cell
    }
}
