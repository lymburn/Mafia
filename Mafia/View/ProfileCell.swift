//
//  ProfileCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-09.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    let profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ProfileButton"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    let name: UILabel = {
        let lb = UILabel()
        lb.text = "Mafia"
        lb.textAlignment = .center
        lb.font = UIFont(name: "Helvetica", size: 12)
        lb.textColor = UIColor(rgb: 0xEDE1BE)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    fileprivate func setupViews() {
        addSubview(name)
        addSubview(profileImage)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: frame.height*0.6).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: frame.height*0.6).isActive = true
        
        name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8).isActive = true
        name.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        name.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
