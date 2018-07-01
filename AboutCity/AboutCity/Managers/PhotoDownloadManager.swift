//
//  PhotoDownloadManager.swift
//  AboutCity
//
//  Created by Pratima Gauns on 7/1/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

//
// Helper extension for megabyte conversion
//
extension UInt64 {
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
}

//
// Class to handle downloading images from the server
//
class PhotoDownloadManager: NSObject {
    static let sharedInstance = PhotoDownloadManager()
    
    private override init() {}
    
    // Fetching the images using operation queues
    let decodeQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.underlyingQueue = DispatchQueue(label: "com.pgauns.PhotoDownloader", attributes: .concurrent)
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
    
    // Initializing the cache for image storing
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    // Method that downloads the image if not exist in cache
    func retrieveImage(for url: String, completion: @escaping (UIImage?) -> Void)  -> ImageRequest? {
        if let image = cachedImage(for: url) {
            completion(image)
            return nil
        }
        
        let queue = decodeQueue.underlyingQueue
        let request = Alamofire.request(url, method: .get)

        let serializer = DataRequest.imageResponseSerializer()
        
        let imageRequest = ImageRequest(request: request)
        imageRequest.request.response(queue: queue, responseSerializer: serializer) { response in
            guard let image = response.result.value else { return }
            
            self.cache(image, for: url)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        return imageRequest
    }
    
    //MARK: - Image Caching
    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
}
