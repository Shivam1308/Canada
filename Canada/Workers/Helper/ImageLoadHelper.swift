//
//  ImageLoadHelper.swift
//  Canada
//
//  Created by Philips on 4/16/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /* loadImageUsingString: Load image async with image cache */
    @objc public func loadImageUsingString(urlString: String) {
        if let url = URL(string: urlString) {
            
            //Cache
            if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                self.image = imageFromCache
                return
            }

            //URL session to download image async
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                    self?.image = UIImage(named: FactCollectionViewCell.PlaceHolder)
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!){
                        imageCache.setObject(image, forKey: urlString as AnyObject)
                        self?.image = UIImage(data: data!)
                    }else{
                        self?.image = UIImage(named: FactCollectionViewCell.PlaceHolder)
                    }
                }
            }).resume()
        }else{
            self.image = UIImage(named: FactCollectionViewCell.PlaceHolder)
        }
    }
    
    /* removeAllCachedKeys: Remove cached save response */
    func removeAllCachedKeys() {
        imageCache.removeAllObjects()
    }
}
