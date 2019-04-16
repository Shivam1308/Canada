//
//  CanadaFactLoader.swift
//  Canada
//
//  Created by Philips on 4/16/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import Foundation

class CanadaFactManager {
    
    func requestCanadaFacts() {
        let restManager = RestClientManager()
        let requestInterface = CanadaFactRequest()
        restManager.invokeGetRequest(requestInterface) {(data, response, error) in
            //Check error
            if error != nil {
                NotificationCenter.default.post(name: Notification.Name("factApiCallback"), object: error, userInfo: nil)
                return
            }
            //Check Data
            if let data = data {
                do {
                    if let newStr = String(data: data, encoding: .iso2022JP){
                        let newData = newStr.data(using: String.Encoding.utf8)
                        _ = try CanadaHelper.saveFactsToFile(newData!, CanadaHelper.factsEndpoint)
                        NotificationCenter.default.post(name: Notification.Name("factApiCallback"), object: nil, userInfo: nil)
                        return
                    }
                }catch{
                    NotificationCenter.default.post(name: Notification.Name("factApiCallback"), object: error, userInfo: nil)
                }
            }
        }
    }}
