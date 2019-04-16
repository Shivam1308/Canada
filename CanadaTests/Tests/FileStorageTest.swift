//
//  FileStorageTest.swift
//  CanadaTests
//
//  Created by Philips on 4/16/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import Foundation
import XCTest
@testable import Canada

class FileStorageTest: XCTestCase {
    
    func testFileStoragePass() {
        let jsonString = "{\"password\" : \"1234\",  \"user\" : \"andreas\"}"
        
        if let data = jsonString.data(using: String.Encoding.utf8) {
            do{
                _ = try CanadaHelper.saveFactsToFile(data, "temp.txt")
                XCTAssert(true)
            }catch{
                XCTAssert(false)
            }
        }
    }
    
    func testFileFetchFail() {
        do{
            _ = try CanadaHelper.fetchFileWithName("tempora.txt")
            XCTAssert(false)
        }catch{
            XCTAssert(true)
        }
    }
    
    func testFileToFetchPass() {
        do{
            _ = try CanadaHelper.fetchFileWithName("temp.txt")
            XCTAssert(true)
        }catch{
            XCTAssert(false)
        }
    }

}
