//
//  TargetCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-07-04.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class TargetCell: BaseTableCell<TableCellInfo> {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    override var info: TableCellInfo! {
        didSet {
            name.text = info.name
        }
    }
    
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(51, 51, 51, 1)
        return label
    }()
    
    fileprivate func setupViews() {
        backgroundColor = .white
        addSubview(name)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()

        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        name.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
