//
//  RestClientManager.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import Foundation

typealias RestClientCompletionHandler = (Data?, URLResponse?, Error?) -> Void

class RestClientManager {

    func invokeGetRequest(_ interface: RestRequestProtocol, completionHandler: @escaping RestClientCompletionHandler) {
        //Check urlrequest
        if let request = makeGetRequest(interface) {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                completionHandler(data, response, error)
            }.resume()
            return
        }
        //Customised Error
        let error = RequestError.invalidRequestParam
        completionHandler(nil, nil,error)
    }
    
    private func makeGetRequest(_ interface: RestRequestProtocol) -> URLRequest? {
        //Check url
        if let url = interface.getURL(){
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = interface.getMethodType()
            return urlRequest
        }
        return nil
    }
}

