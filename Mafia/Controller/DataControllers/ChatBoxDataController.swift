//
//  ChatBoxDataController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class ChatBoxDataController: NSObject, UITableViewDataSource {
    let cellId = "cellId"
    var messageViewModels: [MessageViewModel]!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        cell.messageViewModel = messageViewModels[indexPath.row]
        return cell
    }
    
    let names = ["Jane Doe", "Doctor Strange", "Mr Monopoly", "Ginny Weasley"]
    let messages = ["Good morning Jane how was the weather yesterday" , "Save me tonight", "I think Jane's mafia", "Kill Jane next night ok?"]
    let imageNames = ["Stock 1", "Stock 2", "Stock 3", "Stock 4"]
}

