//
//  TableViewCell.swift
//  AboutCity
//
//  Created by Pratima Gauns on 6/29/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet  weak var titleLabel:UILabel!
    @IBOutlet  weak var descriptionLabel:UILabel!
    @IBOutlet  weak var imageview:UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var tableViewCellModel: TableViewCellModel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.activityIndicator.hidesWhenStopped = true
        
        tableViewCellModel = TableViewCellModel(view: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension TableViewCell: CellView {
    func showActivityIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
    }
    
    func loadImageView(image: UIImage?) {
        self.imageview.image = image
    }
    
    func loadTitle(title: String?) {
        guard let title = title else {
            self.titleLabel.text = "No Title"
            return
        }
        self.titleLabel.text = title
    }
    
    func loadDescription(description: String?) {
        guard let description = description else {
            self.descriptionLabel.text = "No Description Found"
            return
        }
        self.descriptionLabel.text = description
    }
}
