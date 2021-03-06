//
//  TableViewCellModel.swift
//  AboutCity
//
//  Created by Pratima Gauns on 7/1/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

protocol CellView {
    func loadImageView(image: UIImage?)
    func loadTitle(title: String?)
    func loadDescription(description: String?)
}

class TableViewCellModel: NSObject {
    
    let view:CellView!
    var request: ImageRequest?
    
    init(view: CellView) {
        self.view = view
    }
    
    func configureView(with dataRow: DataRow) {
        self.reset()
        self.view.loadTitle(title: dataRow.title)
        self.view.loadDescription(description: dataRow.rowDescription)
        
        guard let imageUrl = dataRow.imageHref else {
            self.view.loadImageView(image: #imageLiteral(resourceName: "no-image"))
            return
        }
        
        self.request = PhotoDownloadManager.sharedInstance.retrieveImage(for: imageUrl, completion: { [weak self] image in
            guard let downloadedImage = image else {
                self?.view.loadImageView(image: #imageLiteral(resourceName: "no-image"))
                return
            }
            self?.view.loadImageView(image: downloadedImage)
        })
    }
    
    func reset() {
        self.view.loadImageView(image: nil)
        request?.cancel()
    }
}
