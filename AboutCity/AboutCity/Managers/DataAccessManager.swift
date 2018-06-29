//
//  DataAccessManager.swift
//  AboutCity
//
//  Created by Pratima Gauns on 6/29/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

class DataAccessManager: NSObject {
    static let sharedInstance = DataAccessManager()

    private override init() {}
    
    func fetchData(completion: @escaping (_ data: ResponseData?, _ error: DataError?) -> Void) {

        NetworkAccess().getData(searchURL: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", completion:  {
            (response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(ResponseData.self, from: response!)
                completion(responseData, nil)
            }
            catch {
                completion(nil, DataError.InvalidData)
            }
        })
    }
}
