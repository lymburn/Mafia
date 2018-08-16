//
//  Message.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-10.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import Foundation

struct Message: Codable {
    var content: String
    var sender: String
    var type: String
}
