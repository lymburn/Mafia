//
//  LobbyCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-09.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class LobbyCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ProfileButton"))
        iv.layer.cornerRadius = iv.frame.height/2
        iv.layer.borderColor = UIColor(rgb: 0xEDE1BE).cgColor
        iv.clipsToBounds = true
        iv.layer.masksToBounds = false
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let name: UILabel = {
        let lb = UILabel()
        lb.text = "Mafia"
        lb.font = UIFont(name: "Helvetica", size: 25)
        lb.textColor = UIColor(rgb: 0xEDE1BE)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    fileprivate func setupViews() {
        addSubview(profileImage)
        addSubview(name)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        name.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        name.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        name.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
