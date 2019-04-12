//
//  CollectionDataSourceDelegate.swift
//  Canada
//
//  Created by Philips on 4/12/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

class CollectionDataSourceDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override init() {
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "factCell", for: indexPath) as! FactCollectionViewCell
        return cell
    }
    
}
