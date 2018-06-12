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
        label.textColor = UIColor.lightGray
        return label
    }()
    
    fileprivate func setupViews() {
        addSubview(messageTextView)
        addSubview(name)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        name.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        messageTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        messageTextView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16).isActive = true
        messageTextView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
