//
//  TargetListView.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-07-04.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class TargetListView: BaseView {
    let header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose Target"
        label.textAlignment = .center
        label.textColor = UIColor.rgb(51, 51, 51, 1)
        label.backgroundColor = .clear
        label.font = UIFont(name: "Helvetica", size: 25)
        return label
    }()
    
    let targetListTable: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .clear
        tv.tableFooterView = UIView()
        tv.backgroundColor = .white
        return tv
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        addSubview(header)
        addSubview(targetListTable)
        updateConstraints()
        
        targetListTable.register(TargetCell.self, forCellReuseIdentifier: cellId)
        targetListTable.rowHeight = 100
    }
    
    let cellId = "cellId"
    let dataSource = TargetsDataController()
    
    override func updateConstraints() {
        super.updateConstraints()
        
        header.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        header.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        targetListTable.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        targetListTable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        targetListTable.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8).isActive = true
        targetListTable.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
