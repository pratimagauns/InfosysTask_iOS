//
//  NetworkAccess.swift
//  AboutCity
//
//  Created by Pratima Gauns on 6/29/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

enum DataError :String{
    case NetworkError
    case NoData
    case InvalidData
    case MissingSearchURL
}

class NetworkAccess: NSObject {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getData(searchURL: String, completion: @escaping (_ success: Data?, _ error: DataError?) -> Void) {
        let url = URL(string: searchURL)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in
            
            guard error == nil else {
                completion(nil, DataError.NetworkError)
                return
            }
            
            guard let content = data else {
                print("No data")
                completion(nil, DataError.NoData)
                return
            }
            
            let responseStrInISOLatin = String(data: content, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                completion(nil, DataError.InvalidData)
                return
            }
            completion(modifiedDataInUTF8Format, nil)
        }
        
        task.resume()
    }
}
