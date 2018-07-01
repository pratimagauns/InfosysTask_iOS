//
//  Connectivity.swift
//  AboutCity
//
//  Created by Pratima Gauns on 7/2/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit
import Alamofire

struct Connectivity{
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
