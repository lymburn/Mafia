//
//  PlayerListCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-13.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class PlayerListView: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        playerTable.register(PlayerCell.self, forCellReuseIdentifier: cellId)
        playerTable.rowHeight = 100
        
        playerTable.dataSource = playerTableDataSource
    }
    
    let cellId = "cellId"
    let playerTableDataSource = PlayerTableDataSource()
    
    let playerTable: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .black
        tv.separatorInset = .zero
        tv.allowsSelection = false
        tv.tableFooterView = UIView()
        return tv
    }()
    
    fileprivate func setupViews() {
        addSubview(playerTable)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        playerTable.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        playerTable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        playerTable.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        playerTable.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
