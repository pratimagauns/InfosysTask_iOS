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
    var tableView = UITableView()
    var viewControllerModel:ViewControllerModel!
    var activityIndicator = UIActivityIndicatorView()
    
    let searchURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    let CellIdentifier = "Cell"

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
        
        viewControllerModel = ViewControllerModel(view: self)
        
        self.setupTableView()
        self.setupActivityIndicator()
        
        viewControllerModel.fetchData(searchURL: searchURL)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(TableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)

        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewControllerModel.fetchData(searchURL: searchURL)
    }
}

extension ViewController: View {
    func didFetchResults(dataRows: [DataRow]) {
        refreshControl.endRefreshing()
        self.dataRows = dataRows
        self.tableView.reloadData()
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier,
                                                    for: indexPath) as? TableViewCell
        {
            cell.tableViewCellModel.configureView(with: dataRows[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataRows.count
    }
}

