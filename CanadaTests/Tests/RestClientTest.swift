//
//  RestClientTest.swift
//  CanadaTests
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import XCTest
@testable import Canada

class RestClientTest: XCTestCase {
    
    let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var restClient: RestClientManager?
    var responseData: Data?
    
    override func setUp() {
        restClient = RestClientManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
/* RestClient Test case Fail */
    func testRestClientFail() {
        let restProtocol = CanadaRequestTest(nil)
        let expectation = self.expectation(description: "Not a valid response")
        
        restClient?.invokeGetRequest(restProtocol, completionHandler: { [weak self](data, response, error) in
            if let data = data{
                self?.responseData = data
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNil(responseData)
    }

/* RestClient Test case Pass */
    func testRestClientPass() {
        let restProtocol = CanadaRequestTest(baseUrl)
        let expectation = self.expectation(description: "Not a valid response")
        
        restClient?.invokeGetRequest(restProtocol, completionHandler: { [weak self](data, response, error) in
            if let data = data{
                self?.responseData = data
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(responseData)
    }

}
