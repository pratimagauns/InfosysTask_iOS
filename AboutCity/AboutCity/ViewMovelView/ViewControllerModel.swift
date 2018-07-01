//
//  ViewModel.swift
//  AboutCity
//
//  Created by Pratima Gauns on 7/1/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

protocol View {
    func showActivityIndicator()
    func hideActivityIndicator()
    func didFetchResults(dataRows: [DataRow])
    func showError(error: String)
    func setTitle(title: String)
}
class ViewControllerModel: NSObject {
    let view:View!
    
    init(view: View) {
        self.view = view
    }
    
    func fetchData(searchURL: String) {
        self.view.showActivityIndicator()
        DataAccessManager.sharedInstance.fetchData(searchURL: searchURL, completion: {
            [weak self] (response, error) in
            
            DispatchQueue.main.async {
                self?.view.hideActivityIndicator()
                if let _ = error {
                    self?.view.showError(error: "Unable to fetch data")
                }
                
                guard let dataRows = response?.rows else {
                    self?.view.showError(error: "Unable to fetch data")
                    return
                }
                
                self?.view.setTitle(title: (response?.title!)!)
                self?.view.didFetchResults(dataRows: dataRows)
            }
        })
    }
}
