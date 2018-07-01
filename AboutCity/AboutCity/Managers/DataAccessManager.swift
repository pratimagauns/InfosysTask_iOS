//
//  DataAccessManager.swift
//  AboutCity
//
//  Created by Pratima Gauns on 6/29/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

//
// Class to handle fetching the initial JSON data from the server
//
class DataAccessManager: NSObject {
    static let sharedInstance = DataAccessManager()
    private override init() {}
    
    func fetchData(searchURL: String, completion: @escaping (_ data: ResponseData?, _ error: DataError?) -> Void) {
        if searchURL.isEmpty {
            completion(nil, .MissingSearchURL)
            return
        }
        
        if Connectivity.sharedInstance.isReachable == false {
            completion(nil, DataError.NetworkError)
            return
        }
        
        NetworkAccess().getData(searchURL: searchURL, completion:  {
            (response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                // Decoding the JSON string to ResponseData object
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
