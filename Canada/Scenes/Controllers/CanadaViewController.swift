//
//  ViewController.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit
import Alamofire

class CanadaViewController: UIViewController {

    var factCollection: UICollectionView!
    var refreshControl: UIRefreshControl!
    lazy var factDataSourceAndDelegate = FactsDataSourceDelegate()
    let reachabilityManager = NetworkReachabilityManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionViewWithLayout()
        addInternetListener()
        invokeRequestLoader()
    }
    
    func addInternetListener() {
        reachabilityManager?.startListening()
        reachabilityManager?.listener = { [unowned self] _ in
            if let isNetworkReachable = self.reachabilityManager?.isReachable,
                isNetworkReachable == true {
                //Adding refresh Control
                self.refreshControl = UIRefreshControl()
                self.refreshControl.tintColor = CanadaHelper.themeColor
                self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
                self.factCollection.addSubview(self.refreshControl)
                self.view.addSubview(self.factCollection)
            } else {
                self.refreshControl.removeFromSuperview()
                self.refreshControl = nil
            }
        }
    }
    
    deinit {
        reachabilityManager?.stopListening()
    }
}

extension CanadaViewController {

    func createCollectionViewWithLayout() {
        
        //Adding collection view
        let frame = self.view.frame
        let layout = UICollectionViewFlowLayout()
        factCollection = UICollectionView(frame: frame, collectionViewLayout: layout)
        factCollection.backgroundColor = UIColor.white
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
        
    }
    
    func invokeRequestLoader() {
        CanadaHelper.showActivityIndicator(self.view)
        //Request for server data
        let canadaManager = CanadaFactManager()
        canadaManager.requestCanadaFacts {[unowned self](data, error) in

            DispatchQueue.main.async {
            CanadaHelper.hideActivityIndicator(self.view)
                if (self.refreshControl != nil) {
                    self.refreshControl.endRefreshing()
                }
            }
            //Error check
            if let error = error{
                CanadaHelper.showAlertMessage(controller: self, titleStr: "Error", messageStr: error.localizedDescription)
                return
            }
            
            do {
                // fetch facts
                self.factDataSourceAndDelegate.facts = try JSONDecoder().decode(CanadaFacts.self, from: data!)
                self.factCollection.delegate = self.factDataSourceAndDelegate
                self.factCollection.dataSource = self.factDataSourceAndDelegate

                DispatchQueue.main.async {
                    self.factCollection.reloadData()
                    self.title = self.factDataSourceAndDelegate.facts?.title
                }
            } catch {
                CanadaHelper.showAlertMessage(controller: self, titleStr: "Error", messageStr: error.localizedDescription)
            }
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

