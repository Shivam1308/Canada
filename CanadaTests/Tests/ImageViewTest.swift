//
//  ImageViewTest.swift
//  CanadaTests
//
//  Created by Philips on 4/16/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import Foundation
import XCTest
@testable import Canada

class ImageViewTest: XCTestCase {
    
    var imageView: UIImageView?

    override func setUp() {
        imageView = UIImageView()
        UIImageView.swizzle
    }
    
    override func tearDown() {
        UIImageView.deSwizzle
    }
    
    func testForImageLoaderDetect() {
        imageView?.loadImageUsingString(urlString:"https://www.socialsciencespace.com/wp-content/uploads/Speak-Dummy.jpg")
        XCTAssertNotNil(SharedInstanceClass.shared.imageView)
    }
}
