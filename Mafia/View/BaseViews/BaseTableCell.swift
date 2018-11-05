//
//  BaseTableCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-30.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

struct TableCellInfo {
    var name: String?
    var message: String?
    var imageName: String?
}

class BaseTableCell<U>: UITableViewCell {
    var info: U!
}
