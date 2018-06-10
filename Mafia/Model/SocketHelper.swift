//
//  SocketHelper.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-10.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import SocketIO

protocol SocketHelperDelegate: class {
    func messageReceived()
}

class SocketHelper {
    private let serverId = "http://ec2-18-191-123-240.us-east-2.compute.amazonaws.com:8080/"
    private var manager:SocketManager!
    private var socket: SocketIOClient!
    var messageInfo: [String: Any?]!
    weak var delegate: SocketHelperDelegate? = nil
    
    func setupSocket(name: String, gameId: Int) {
        manager = SocketManager(socketURL: URL(string: serverId)!, config: [.log(false), .compress, .forceWebsockets(true), .reconnects(true)])
        socket = manager.defaultSocket
        socket.on(clientEvent: .connect) {data, ack in
            //Register user after connecting
            let msgJSON: [String : Any] = ["player_name": name, "game_id": gameId]
            self.socket.emit("joinGameRoom", msgJSON)
        }
        
        socket.on("messageToClient") {data, ack in
            self.messageInfo = data[0] as! [String : Any?]
            self.delegate?.messageReceived()
        }
        
        socket.connect()
    }
    
    func sendMessage(name: String, message: String, gameId: Int) {
        let msgJSON: [String : Any] = ["player_name" : name, "message" : message, "game_id": 123]
        socket.emit("messageToServer", msgJSON)
    }
    
    func getMessage() -> Message {
        var message = Message()
        if let content = messageInfo["message"] as? String, let name = messageInfo["player_name"] as? String {
            message.content = content
            message.sender = name
        }
        return message
    }
}
