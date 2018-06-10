//
//  SocketHelper.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-10.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import SocketIO

class SocketHelper {
    private let serverId = "http://ec2-18-191-123-240.us-east-2.compute.amazonaws.com:8080/"
    private var manager:SocketManager!
    private var socket: SocketIOClient!
    
    func setupSocket(name: String, gameId: Int) {
        manager = SocketManager(socketURL: URL(string: serverId)!, config: [.log(true), .compress, .forceWebsockets(true), .reconnects(true)])
        socket = manager.defaultSocket
        socket.on(clientEvent: .connect) {data, ack in
            //Register user after connecting
            let msgJSON: [String : Any] = ["player_name": "Eugene", "game_id": 123]
            self.socket.emit("joinGameRoom", msgJSON)
        }
        
        socket.on("messageToClient") {data, ack in
            
        }
        
        socket.connect()
    }
    
    func sendMessage(name: String, message: String, gameId: Int) {
        let msgJSON: [String : Any] = ["player_name" : name, "message" : message, "game_id": 123]
        socket.emit("messageToServer", msgJSON)
    }
}
