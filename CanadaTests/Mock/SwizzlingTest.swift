//
//  SwizzlingTest.swift
//  CanadaTests
//
//  Created by Philips on 4/16/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit
import Canada

private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    guard
        let originalMethod = class_getInstanceMethod(forClass, originalSelector),
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        else { return }
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

extension UIImageView {
    
    static let swizzle: Void = {
        let originalSelector = #selector(loadImageUsingString(urlString:))
        let swizzledSelector = #selector(loadImageUsingDeSwizzlingString(urlString:))
        swizzling(UIImageView.self, originalSelector, swizzledSelector)
    }()
    
    static let deSwizzle: Void = {
        let originalSelector = #selector(loadImageUsingDeSwizzlingString(urlString:))
        let swizzledSelector = #selector(loadImageUsingString(urlString:))
        swizzling(UIImageView.self, originalSelector, swizzledSelector)
    }()
    
    @objc func loadImageUsingDeSwizzlingString(urlString: String) {
        
        if urlString == "" {
            SharedInstanceClass.shared.imageView = nil
            return
        }
        SharedInstanceClass.shared.imageView = UIImageView()
        SharedInstanceClass.shared.imageView?.image = UIImage(named: "Placeholder");
    }

}

extension CanadaHelper {
    
}
