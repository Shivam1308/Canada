//
//  CanadaConstant.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

public class CanadaHelper {

    static let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
    static let factsEndpoint = "facts.json"
    private static var activityIndicator: UIActivityIndicatorView?
    static let themeColor:UIColor = UIColor(red: 47/255, green: 106/255, blue: 158/255, alpha: 1.0)
    
    /* showAlertMessage: show alert with the help of controller, titleStr, messageStr */
    class func showAlertMessage(controller: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler:nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    /* saveFactsToFile: save file to local directory */
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
    
    /* fetchFileWithName: fetch file from local directory */
    class func fetchFileWithName(_ fileName: String)throws -> Data? {
        let filename = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: filename)
            return data
        } catch {
            throw error
        }
    }
    
    /* showActivityIndicator: show indicator with view */
    class func showActivityIndicator(_ view: UIView) {
        //Create Activity Indicator
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator?.center = view.center
        activityIndicator?.hidesWhenStopped = false
        activityIndicator?.startAnimating()
        if let ac = activityIndicator {
            view.addSubview(ac)
        }
    }
    
    /* hideActivityIndicator: hide indicator with view */
    class func hideActivityIndicator(_ view: UIView){
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
    
    private class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
