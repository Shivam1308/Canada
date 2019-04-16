//
//  CanadaFacts.swift
//  Canada
//
//  Created by Philips on 4/11/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import Foundation

/* Fetch Data Model */
struct CanadaFacts: Codable {
    let title: String?
    let rows: [Row]
}

struct Row: Codable {
    let title, description: String?
    let imageHref: String?
}
