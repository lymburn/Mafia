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
        
        keyboardView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    let cellId = "cellId"
    
    let chatLabel: UILabel = {
        let label = UILabel()
        label.text = "Chat"
        label.font = UIFont(name: "Helvetica", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    let chatBox: UITableView = {
        let cv = UITableView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.separatorColor = .clear
        cv.allowsSelection = false
        cv.tableFooterView = UIView()
        cv.backgroundColor = .clear
        return cv
    }()
    
    let keyboardView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Helvetica", size: 16)
        textView.textColor = .black
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.clipsToBounds = true
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        return textView
    }()
    
    let sendButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(named: "SendButton"), for: .normal)
        return bt
    }()
    
    fileprivate func setupViews() {
        addSubview(chatBox)
        addSubview(keyboardView)
        keyboardView.addSubview(sendButton)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        chatBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        chatBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        chatBox.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        chatBox.bottomAnchor.constraint(equalTo: keyboardView.topAnchor, constant: -32).isActive = true
        
        keyboardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        keyboardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        keyboardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        keyboardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = keyboardView.sizeThatFits(size)
        keyboardView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
