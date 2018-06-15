//
//  NotificationView.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-14.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "Notifications"
        label.font = UIFont(name: "Helvetica", size: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(51, 51, 51, 1)
        return label
    }()
    
    let newsTable: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.allowsSelection = false
        tv.tableFooterView = UIView()
        tv.backgroundColor = .clear
        return tv
    }()

    fileprivate func setupViews() {
        addSubview(newsTable)
        addSubview(header)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        header.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        header.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        newsTable.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        newsTable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        newsTable.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        newsTable.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
