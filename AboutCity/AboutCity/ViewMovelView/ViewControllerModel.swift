//
//  ViewModel.swift
//  AboutCity
//
//  Created by Pratima Gauns on 7/1/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

protocol View {
    func didFetchResults(dataRows: [DataRow])
    func showError(error: String)
}
class ViewControllerModel: NSObject {
    let view:View!
    
    init(view: View) {
        self.view = view
    }
    
    func fetchData() {
        DataAccessManager.sharedInstance.fetchData(completion: {
            [weak self] (response, error) in
            if let _ = error {
                self?.view.showError(error: error.debugDescription)
            }
            
            guard let dataRows = response?.rows else {
                self?.view.showError(error: "Unable to fetch data")
                return
            }
            
            DispatchQueue.main.async {
                self?.view.didFetchResults(dataRows: dataRows)
            }
        })
    }
}
