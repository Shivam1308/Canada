//
//  ViewController.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

class CanadaViewController: UIViewController {

    var factCollection: UICollectionView!
    let factDataSourceAndDelegate = CollectionDataSourceDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionViewWithLayout()
    }
}

extension CanadaViewController {
    func createCollectionViewWithLayout() {
        
        //Adding collection view
        let frame = self.view.frame
        let layout = UICollectionViewFlowLayout()
        factCollection = UICollectionView(frame: frame, collectionViewLayout: layout)
        factCollection.backgroundColor = UIColor.white
        self.view.addSubview(factCollection)
        
        //Auto layout for collection view
        factCollection.translatesAutoresizingMaskIntoConstraints = false
        factCollection.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        factCollection.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        factCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        factCollection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Register cell and delegate call
        factCollection.register(FactCollectionViewCell.self, forCellWithReuseIdentifier: "factCell")
        factCollection.delegate = factDataSourceAndDelegate
        factCollection.dataSource = factDataSourceAndDelegate
    }
}

