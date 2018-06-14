//
//  ChatMessageCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-09.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()

    }
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Sample"
        textView.font = UIFont(name: "Helvetica", size: 16)
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor(rgb: 0x551A8B)
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor(rgb: 0x551A8B).cgColor
        textView.layer.borderWidth = 2
        return textView
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "Eugene"
        label.font = UIFont(name: "Helvetica", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(51, 51, 51, 1)
        return label
    }()
    
    let profilePic: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Stock 1"))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate func setupViews() {
        addSubview(messageTextView)
        addSubview(name)
        addSubview(profilePic)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        profilePic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        profilePic.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        profilePic.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profilePic.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        name.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        name.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 12).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        messageTextView.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 12).isActive = true
        messageTextView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16).isActive = true
        messageTextView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
