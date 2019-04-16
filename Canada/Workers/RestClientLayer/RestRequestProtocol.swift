//
//  RestRequestInterface.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import Foundation

enum MethodType: String {
    case GET = "GET"
    case POST = "POST"
}

/* RestRequestProtocol to set request protocol methods */
public protocol RestRequestProtocol {
    func getURL() -> URL?
    func getMethodType() -> String
    func getHeaderContent() -> Dictionary<String, String>?
    func getBodyContent() -> Data?
}
