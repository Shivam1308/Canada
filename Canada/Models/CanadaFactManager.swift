//
//  CanadaFactLoader.swift
//  Canada
//
//  Created by Philips on 4/16/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import Foundation

typealias ManagerCompletionHandler = (Data?, Error?) -> Void

class CanadaFactManager {
    
    func requestCanadaFacts(_ completionHandler: @escaping ManagerCompletionHandler) {
        let restManager = RestClientManager()
        let requestInterface = CanadaFactRequest()
        restManager.invokeGetRequest(requestInterface) {(data, response, error) in
            //Check error
            if error != nil {
                completionHandler(nil,error)
                return
            }
            //Check Data
            if let data = data {
                    if let newStr = String(data: data, encoding: .iso2022JP){
                        let newData = newStr.data(using: String.Encoding.utf8)
                        completionHandler(newData, nil)
                        return
                    }
            }
            //Customised Error
            let error = RequestError.invalidDataFormat
            completionHandler(nil,error)
        }
    }}
