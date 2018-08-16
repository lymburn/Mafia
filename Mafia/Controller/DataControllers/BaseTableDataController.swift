//
//  BaseTableDataController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-30.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//
import UIKit

class BaseTableDataController<T: BaseTableCell<U>, U>: NSObject, UITableViewDataSource {
    var infos = [U]()
    
    let cellId = "cellId"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BaseTableCell<U>
        cell.info = infos[indexPath.row]
        return cell
    }
}
