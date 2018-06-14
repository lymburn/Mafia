//
//  PlayerCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-13.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.rgb(230, 230, 230, 1)
        setupViews()
    }
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "Eugene"
        label.font = UIFont(name: "Helvetica", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let profilePic: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "SendButton"))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate func setupViews() {
        addSubview(profilePic)
        addSubview(name)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        profilePic.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profilePic.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profilePic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        profilePic.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        name.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 8).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        name.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        name.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
