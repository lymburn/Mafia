//
//  GameMenuBar.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-09.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class GameMenuBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let roleImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ProfileButton"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let roleName: UILabel = {
        let lb = UILabel()
        lb.text = "Mafia"
        lb.textAlignment = .center
        lb.font = UIFont(name: "Helvetica", size: 25)
        lb.textColor = UIColor(rgb: 0xef6e31)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    fileprivate func setupViews() {
        addSubview(roleImage)
        addSubview(roleName)
        self.updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        roleImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        roleImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        roleImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        roleImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        roleName.topAnchor.constraint(equalTo: roleImage.bottomAnchor, constant: 8).isActive = true
        roleName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        roleName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        roleName.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
