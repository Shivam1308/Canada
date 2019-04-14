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
    lazy var factDataSourceAndDelegate = CollectionDataSourceDelegate()
    var dataPresent: Bool = false
    var factsData: CanadaFacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFactsFromStorage()
        createCollectionViewWithLayout()
        restRequestForCanadaFacts()
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
        factCollection.reloadData()
    }
    
    func fetchFactsFromStorage() {
        do {
            factsData = try CanadaConstant.fetchFileWithName(CanadaConstant.factsEndpoint)
            self.title = factsData?.title
            dataPresent = true
        }catch{
            factsData = nil
        }
    }
    
    func restRequestForCanadaFacts() {
        let restManager = RestClientManager()
        let requestInterface = CanadaFactRequest()
        restManager.invokeGetRequest(requestInterface) { [unowned self] (data, response, error) in
            
            //Check error
            if let error = error {
                CanadaConstant.showAlertMessage(controller: self, titleStr: "Error", messageStr: error.localizedDescription)
            }
            
            //Check Data
            if let data = data {
                do {
                    let newStr = String(data: data, encoding: .iso2022JP)
                    let newData = newStr!.data(using: String.Encoding.utf8)
                    _ = try CanadaConstant.saveFactsToFile(newData!, CanadaConstant.factsEndpoint)
                }catch{
                    CanadaConstant.showAlertMessage(controller: self, titleStr: "Error", messageStr: error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
}

