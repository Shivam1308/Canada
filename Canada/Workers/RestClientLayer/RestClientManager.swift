//
//  RestClientManager.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import Foundation
import Alamofire

typealias RestClientCompletionHandler = (Data?, URLResponse?, Error?) -> Void

class RestClientManager {

    func invokeGetRequest(_ interface: RestRequestProtocol, completionHandler: @escaping RestClientCompletionHandler) {
        //Check urlrequest
        if let url = interface.getURL(){
            Alamofire.request(url).responseJSON { response in
                completionHandler(response.data, response.response, response.result.error)
            }
            return
        }
        //Customised Error
        let error = RequestError.invalidRequestParam
        completionHandler(nil, nil,error)
    }

}

