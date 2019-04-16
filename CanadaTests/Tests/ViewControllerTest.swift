//
//  ViewControllerTest.swift
//  CanadaTests
//
//  Created by Philips on 4/16/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit
import XCTest
@testable import Canada

class ViewControllerTest: XCTestCase {
    
    var viewController: CanadaViewController?
    var navigationController: UINavigationController?

    override func setUp() {
        navigationController = UINavigationController()
        let canadaViewController = CanadaViewController()
        navigationController?.viewControllers = [canadaViewController]
        viewController = navigationController!.topViewController as? CanadaViewController
        let screenSize = UIScreen.main.bounds
        let frame = screenSize
        let layout = UICollectionViewFlowLayout()
        viewController?.factCollection = UICollectionView(frame: frame, collectionViewLayout: layout)
        viewController?.factCollection.register(FactCollectionViewCell.self, forCellWithReuseIdentifier: "factCell")
        //assigning to window
        UIApplication.shared.keyWindow!.rootViewController = navigationController
    }
    
    override func tearDown() {
        
    }
    
    func testViewControllerAndNavigationController() {
        XCTAssertNotNil(navigationController)
        XCTAssertNotNil(viewController?.view)
        XCTAssertNotNil(viewController?.factCollection)
    }
    
    func testCollectionViewCellsIsDisplayed() {
        viewController?.factCollection.reloadData()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))
        let cells = viewController?.factCollection.visibleCells as! [FactCollectionViewCell]
        XCTAssertTrue(cells.count > 0, "Cells count should be greater then zero")
    }
}
