//
//  ImageRequest.swift
//  AboutCity
//
//  Created by Pratima Gauns on 7/1/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ImageRequest: NSObject {
    var decodeOperation: Operation?
    var request: DataRequest
    
    init(request: DataRequest) {
        self.request = request
    }
    
    func cancel() {
        decodeOperation?.cancel()
        request.cancel()
    }
}
