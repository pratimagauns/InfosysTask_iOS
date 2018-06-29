//
//  ViewController.swift
//  AboutCity
//
//  Created by Pratima Gauns on 6/29/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DataAccessManager.sharedInstance.fetchData(completion: {
            (response, error) in
            
            print(response?.title)
           
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

