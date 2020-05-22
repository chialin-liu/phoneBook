//
//  ConnectionCell.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/22.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
class ConnectionCell: UITableViewCell {
    var connection: Connection? {
        didSet {
            if let imageData = connection?.imageData {
                photoImageView.image = UIImage(data: imageData)
            }
            if let name = connection?.name, let buildDate = connection?.buildDate {
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy, MMM dd"
                let dateString = dateFormat.string(from: buildDate)
                nameDateLabel.text = "\(name), connected: \(dateString)"
            } else {
                nameDateLabel.text = connection?.name
            }
        }
    }
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "addPhoto")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    let nameDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemTeal
        addSubview(photoImageView)
        addSubview(nameDateLabel)
        photoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        nameDateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameDateLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 6).isActive = true
        nameDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        nameDateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
