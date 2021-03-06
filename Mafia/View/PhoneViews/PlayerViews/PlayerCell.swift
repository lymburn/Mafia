//
//  PlayerCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-13.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class PlayerCell: BaseTableCell<TableCellInfo> {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    override var info: TableCellInfo! {
        didSet {
            name.text = info.name
            messageText.text = info.message
            profilePic.image = UIImage(named: info.imageName ?? "")
        }
    }
    
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(51, 51, 51, 1)
        return label
    }()
    
    let profilePic: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let messageText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Helvetica", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    fileprivate func setupViews() {
        backgroundColor = .white
        addSubview(profilePic)
        addSubview(name)
        addSubview(messageText)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        profilePic.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profilePic.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profilePic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        profilePic.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        name.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        name.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        messageText.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 16).isActive = true
        messageText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        messageText.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8).isActive = true
        messageText.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
