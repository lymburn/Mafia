//
//  NotificationView.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-14.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class NotificationView: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupViews()
        
        newsTable.register(NotificationCell.self, forCellReuseIdentifier: cellId)
        newsTable.estimatedRowHeight = 100
        newsTable.rowHeight = UITableView.automaticDimension
    }
    
    let cellId = "cellId"
    
    let statusBar: StatusBar = {
        let sb = StatusBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "Notifications"
        label.font = UIFont(name: "Helvetica", size: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
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
        addSubview(statusBar)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        statusBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        statusBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        statusBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        statusBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        header.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        header.topAnchor.constraint(equalTo: statusBar.bottomAnchor, constant: 8).isActive = true
        header.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        newsTable.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        newsTable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        newsTable.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        newsTable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
