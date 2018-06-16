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
    }
    
    let cellId = "cellId"
    
    let header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Messages"
        label.textAlignment = .center
        label.textColor = UIColor.rgb(51, 51, 51, 1)
        label.backgroundColor = .clear
        label.font = UIFont(name: "Magical Mystery Tour", size: 40)
        return label
    }()
    
    let playerTable: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .clear
        tv.tableFooterView = UIView()
        tv.backgroundColor = .white
        return tv
    }()
    
    fileprivate func setupViews() {
        addSubview(header)
        addSubview(playerTable)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()

        header.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 38).isActive = true
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        playerTable.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        playerTable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        playerTable.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8).isActive = true
        playerTable.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
