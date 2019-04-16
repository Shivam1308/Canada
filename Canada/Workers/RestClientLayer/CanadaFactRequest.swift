//
//  CanadaFactRequest.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

/* CanadaFactRequest to set request params*/
class CanadaFactRequest: RestRequestProtocol {
    
    func getURL() -> URL? {
        return URL(string: CanadaHelper.baseUrl + CanadaHelper.factsEndpoint)
    }
    
    func getMethodType() -> String {
        return MethodType.GET.rawValue
    }
    
    func getHeaderContent() -> Dictionary<String, String>? {
        return nil
    }
    
    func getBodyContent() -> Data? {
        return nil
    }
    

}
