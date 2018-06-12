//
//  ChatView.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-11.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class ChatViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        chatBox.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        chatBox.estimatedRowHeight = 100
        chatBox.rowHeight = UITableViewAutomaticDimension
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        keyboardView.centerVertically()
    }
    
    let cellId = "cellId"
    
    let chatBox: UITableView = {
        let cv = UITableView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.separatorColor = .clear
        cv.allowsSelection = false
        cv.tableFooterView = UIView()
        cv.backgroundColor = .clear
        cv.layer.borderWidth = 1
        cv.layer.borderColor = UIColor.black.cgColor
        cv.layer.cornerRadius = 10
        return cv
    }()
    
    let keyboardView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Helvetica", size: 16)
        textView.textColor = .white
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.backgroundColor = .clear
        return textView
    }()
    
    fileprivate func setupViews() {
        addSubview(chatBox)
        addSubview(keyboardView)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        chatBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        chatBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        chatBox.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        chatBox.bottomAnchor.constraint(equalTo: keyboardView.topAnchor, constant: -32).isActive = true
        
        keyboardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        keyboardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        keyboardView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        keyboardView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
