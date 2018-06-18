//
//  NotificationCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        return container
    }()
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "CBC News"
        label.font = UIFont(name: "Helvetica", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    let icon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Stock 1"))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let newsDescription: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Lorem ipsum dolor sit amet, an epicuri forensibus mea, cum nibh insolens eu, eu repudiandae accommodare eum. Zril doctus ut cum. An mea sapientem voluptatum, mea ad nonumy putant. Eu quas adipiscing voluptatum ius, mei causae recteque et, ea delectus constituam scriptorem pri. Sea in atomorum adolescens, duo illum nostrud referrentur id, mea vero volutpat et."
        textView.font = UIFont(name: "Helvetica", size: 14)
        textView.textColor = UIColor.black
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    fileprivate func setupViews() {
        addSubview(container)
        addSubview(header)
        addSubview(icon)
        addSubview(newsDescription)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        header.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        newsDescription.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
        newsDescription.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24).isActive = true
        newsDescription.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        newsDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
