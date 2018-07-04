//
//  ChatHeaderBar.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-14.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import Foundation

import UIKit

protocol ChatHeaderBarDelegate: class {
    func backPressed()
}

class ChatHeaderBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    weak var delegate: ChatHeaderBarDelegate? = nil
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "Town Chat"
        label.font = UIFont(name: "Helvetica", size: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(51, 51, 51, 1)
        return label
    }()
    
    let backButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("←", for: .normal)
        bt.setTitleColor(UIColor.rgb(51, 51, 51, 1), for: .normal)
        bt.addTarget(self, action: #selector(backPressed), for: .touchDown)
        return bt
    }()
    
    fileprivate func setupViews() {
        addSubview(name)
        addSubview(backButton)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        backButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        name.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        name.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatHeaderBar {
    @objc func backPressed() {
        delegate?.backPressed()
    }
}
