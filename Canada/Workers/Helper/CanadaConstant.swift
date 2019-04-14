//
//  CanadaConstant.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

class CanadaConstant {

    static let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
    static let factsEndpoint = "facts.json"
    
    class func showAlertMessage(controller: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler:nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    class func saveFactsToFile(_ data: Data,_ fileName: String)throws -> Bool{
        let filename = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            if (FileManager.default.fileExists(atPath: filename.absoluteString)){
                try FileManager.default.removeItem(at: filename)
            }
            try data.write(to: filename)
            return true
        } catch {
            throw error
            
    
        }
    }
    
    class func fetchFileWithName(_ fileName: String)throws -> CanadaFacts? {
        let filename = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: filename)
            let canadaFacts = try JSONDecoder().decode(CanadaFacts.self, from: data)
            return canadaFacts 
        } catch {
            throw error
        }
    }
    
    private class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
