//
//  MessageViewModel.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-08-15.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import Foundation

struct MessageViewModel {
    let content: String
    let sender: String
    let type: String
    
    init(message: Message) {
        self.content = message.content
        self.sender = message.sender
        self.type = message.type
    }
}
