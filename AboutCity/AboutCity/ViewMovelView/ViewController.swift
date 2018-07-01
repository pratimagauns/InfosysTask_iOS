//
//  ViewController.swift
//  AboutCity
//
//  Created by Pratima Gauns on 6/29/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataRows = [DataRow]()
    @IBOutlet weak var tableview: UITableView!
    var viewControllerModel:ViewControllerModel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let searchURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 340
        
        viewControllerModel = ViewControllerModel(view: self)
        viewControllerModel.fetchData(searchURL: searchURL)
        
        self.tableview.addSubview(self.refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewControllerModel.fetchData(searchURL: searchURL)
    }
}

extension ViewController: View {
    func didFetchResults(dataRows: [DataRow]) {
        refreshControl.endRefreshing()
        self.dataRows = dataRows
        self.tableview.reloadData()
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func showActivityIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! TableViewCell
        
        cell.tableViewCellModel.configureView(with: dataRows[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataRows.count
    }
}

