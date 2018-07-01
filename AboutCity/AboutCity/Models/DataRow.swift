//
//  DataRow.swift
//  AboutCity
//
//  Created by Pratima Gauns on 6/29/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

class DataRow: NSObject, Codable {
    var title: String?
    var rowDescription: String?
    var imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
