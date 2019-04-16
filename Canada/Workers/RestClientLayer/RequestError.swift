//
//  RequestError.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

enum RequestError: Error {
    case invalidRequestParam
}

/* RequestError to set error for multiple case */
extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidRequestParam:
            return NSLocalizedString("URL is missing", comment: "Request Parameter missing")
        }
    }
}
