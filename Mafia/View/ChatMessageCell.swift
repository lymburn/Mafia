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
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    fileprivate func setupViews() {
        addSubview(messageTextView)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        messageTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        messageTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8 ).isActive = true
        messageTextView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
