//
//  PlayerListDataSource.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-13.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol PlayerTableDataControllerDelegate: class {
    func didSelectRowAt(indexPath: IndexPath)
}

class PlayerTableDataController: BaseTableDataController<PlayerCell, TableCellInfo>, UITableViewDelegate {
    override init() {
        super.init()
        populateCells()
    }
    
    func populateCells() {
        for i in 0..<names.count {
            let newCell = TableCellInfo(imageName: imageNames[i])
            infos.append(newCell)
        }
    }
    
    let names = ["Jane Doe", "Doctor Strange", "Mr Monopoly", "Ginny Weasley"]
    let messages = ["Good morning Jane how was the weather yesterday" , "Save me tonight", "I think Jane's mafia", "Kill Jane next night ok?"]
    let imageNames = ["Stock 1", "Stock 2", "Stock 3", "Stock 4"]
    weak var delegate: PlayerTableDataControllerDelegate? = nil
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectRowAt(indexPath: indexPath)
    }
}
