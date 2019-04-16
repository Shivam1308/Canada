//
//  Singeleton.swift
//  CanadaTests
//
//  Created by Philips on 4/16/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import Foundation
import UIKit

class SharedInstanceClass {
    static let shared = SharedInstanceClass()
    var imageView: UIImageView?
    
    private init() {
        
    }
}
