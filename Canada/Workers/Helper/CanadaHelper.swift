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
        DispatchQueue.main.async {
        controller.present(alert, animated: true, completion: nil)
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

}
