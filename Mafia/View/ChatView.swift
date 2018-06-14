//
//  ChatView.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-11.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol ChatViewDelegate: class {
    func sendPressed(message: String)
}

class ChatView: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        chatBox.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        chatBox.estimatedRowHeight = 100
        chatBox.rowHeight = UITableViewAutomaticDimension
        
        keyboardView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        keyboardView.centerVertically()
    }
    
    weak var delegate: ChatViewDelegate? = nil
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
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .clear
        tv.allowsSelection = false
        tv.tableFooterView = UIView()
        tv.backgroundColor = .clear
        return tv
    }()
    
    let keyboardView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Helvetica", size: 20)
        textView.textColor = UIColor(rgb: 0x718093)
        textView.text = "Type your message here..."
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor(rgb: 0xdcdde1)
        textView.isScrollEnabled = false
        textView.returnKeyType = UIReturnKeyType.send
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
        chatBox.topAnchor.constraint(equalTo: topAnchor, constant: 46).isActive = true
        chatBox.bottomAnchor.constraint(equalTo: keyboardView.topAnchor, constant: -32).isActive = true
        
        keyboardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        keyboardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        keyboardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        keyboardView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.isScrollEnabled = false
        
        //Manage placeholder
        if textView.textColor == UIColor(rgb: 0x718093) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.isScrollEnabled = false
        //Replace text with placeholder
        if textView.text.isEmpty {
            textView.text = "Type your message here..."
            textView.textColor = UIColor(rgb: 0x718093)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        let minHeight: CGFloat = 50.0 //Minimum height of text view
        let maxHeight: CGFloat = 62.0 //Max size for 2 lines
        
        if estimatedSize.height > minHeight && estimatedSize.height <= maxHeight {
            print(estimatedSize.height)
            textView.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        } else if estimatedSize.height < minHeight {
            textView.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = 50
                }
            }
        } else {
            textView.isScrollEnabled = true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //If send key is pressed
        if(text == "\n") {
            delegate?.sendPressed(message: textView.text)
            textView.text = nil
            //Reset text view height
            textView.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = 50
                }
            }
            textView.endEditing(true)
            return false
        }
        return true
    }
}
