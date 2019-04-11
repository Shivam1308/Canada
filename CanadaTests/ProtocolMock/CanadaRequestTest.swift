//
//  CanadaRequestTest.swift
//  CanadaTests
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit
import Canada

class CanadaRequestTest: RestRequestProtocol {
    var urlString:String?
    
    init(_ baseUrl: String?) {
        urlString = baseUrl
    }
    
    func getURL() -> URL? {
        if let url = urlString {
            return URL(string: url)
        }
        return nil
    }
    
    func getMethodType() -> String {
        return "GET"
    }
    
    func getHeaderContent() -> Dictionary<String, String>? {
        return nil
    }
    
    func getBodyContent() -> Data? {
        return nil
    }
    

}
