//
//  TargetsDataController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-07-04.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class TargetsDataController: BaseTableDataController<PlayerCell, TableCellInfo>, UITableViewDelegate {
    override init() {
        super.init()
        populateCells()
    }
    
    func populateCells() {
        for i in 0..<names.count {
            let newCell = TableCellInfo(name: names[i], text: nil, imageName: nil)
            infos.append(newCell)
        }
    }
    
    let names = ["Jane Doe", "Doctor Strange", "Mr Monopoly", "Ginny Weasley"]
}
