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
    
    weak var delegate: ChatViewDelegate? = nil
    let cellId = "cellId"
    
    lazy var lineView: UIView = {
        let lineView = UIView(frame: CGRect(x: 0, y: frame.height - 40, width: frame.width, height: 1))
        lineView.backgroundColor = UIColor(rgb: 0xdcdde1)
        return lineView
    }()
    
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
        textView.font = UIFont(name: "Helvetica", size: 16)
        textView.textColor = UIColor(rgb: 0x718093)
        textView.text = "Type your message here..."
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor(rgb: 0xdcdde1)
        textView.isScrollEnabled = true
        textView.returnKeyType = UIReturnKeyType.send
        return textView
    }()
    
    fileprivate func setupViews() {
        addSubview(chatBox)
        addSubview(keyboardView)
        addSubview(lineView)
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
        keyboardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let estimatedSize: CGFloat = 34.5
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize*2
                lineView.frame.origin.y = frame.height - estimatedSize*2
            }
        }
        
        //Manage placeholder
        if textView.textColor == UIColor(rgb: 0x718093) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        lineView.frame.origin.y = frame.height - 40
        
        if textView.text.isEmpty {
            textView.text = "Type your message here..."
            textView.textColor = UIColor(rgb: 0x718093)
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
                    constraint.constant = 40
                }
            }
            textView.endEditing(true)
            return false
        }
        return true
    }
}
