//
//  TableViewCell.swift
//  AboutCity
//
//  Created by Pratima Gauns on 6/29/18.
//  Copyright © 2018 Pratima Gauns. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var imageview = UIImageView()
    
    var tableViewCellModel: TableViewCellModel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.tableViewCellModel = TableViewCellModel(view: self)
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {

        let marginGuide = contentView.layoutMarginsGuide
        
        // configure titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
        // configure imageview
        contentView.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        imageview.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        imageview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        imageview.contentMode = .scaleAspectFit
        
        // configure description label
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: imageview.bottomAnchor).isActive = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Avenir-Book", size: 12)
        descriptionLabel.textColor = UIColor.lightGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension TableViewCell: CellView {
    
    func loadImageView(image: UIImage?) {
        self.imageview.image = image
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
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
