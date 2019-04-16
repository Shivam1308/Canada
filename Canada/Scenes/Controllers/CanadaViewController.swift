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
    var refreshControl: UIRefreshControl!
    lazy var factDataSourceAndDelegate = FactsDataSourceDelegate()
    let dataPresent = "DataPresent"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionViewWithLayout()
        invokeRequestLoader()
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedCallbackFromCanadaManager), name: Notification.Name("factApiCallback"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("factApiCallback"), object: nil)
    }
}

extension CanadaViewController {

    func createCollectionViewWithLayout() {
        //Adding collection view
        let frame = self.view.frame
        let layout = UICollectionViewFlowLayout()
        factCollection = UICollectionView(frame: frame, collectionViewLayout: layout)
        factCollection.backgroundColor = UIColor.white
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = CanadaHelper.themeColor
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        factCollection.addSubview(refreshControl)
        factCollection.alwaysBounceVertical = true
        self.view.addSubview(factCollection)
        
        //Auto layout for collection view
        factCollection.translatesAutoresizingMaskIntoConstraints = false
        factCollection.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        factCollection.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        factCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        factCollection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Register cell and delegate call
        factCollection.register(FactCollectionViewCell.self, forCellWithReuseIdentifier: FactCollectionViewCell.Id)
        
        //Check for data loaded
        if UserDefaults.standard.bool(forKey: dataPresent) {
            self.receivedCallbackFromCanadaManager(nil)
        }
    }
    
    func invokeRequestLoader() {
        CanadaHelper.showActivityIndicator(self.view)
        
        //Request for server data
        let canadaManager = CanadaFactManager()
        canadaManager.requestCanadaFacts()
        
    }
    
    @objc func receivedCallbackFromCanadaManager(_ noti :NSNotification?) {
        self.refreshControl.endRefreshing()
        
        //set bool for data present
        UserDefaults.standard.set(true, forKey: dataPresent);      CanadaHelper.hideActivityIndicator(self.view)
        DispatchQueue.main.async {
            self.factCollection.delegate = self.factDataSourceAndDelegate
            self.factCollection.dataSource = self.factDataSourceAndDelegate
            self.factCollection.reloadData()
            self.title = self.factDataSourceAndDelegate.facts?.title
        }
        //Error check
        if let error = noti?.object as? Error{
            CanadaHelper.showAlertMessage(controller: self, titleStr: "Error", messageStr: error.localizedDescription)
        }
    }
    
    @objc func refreshData() {
        //refresh by setting delegate and souce with cache null
        self.factCollection.delegate = nil
        self.factCollection.dataSource = nil
        UIImageView().removeAllCachedKeys()
        
        //call for request
        invokeRequestLoader()
    }
}

