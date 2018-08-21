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
    static let shared = SocketHelper()
    private let serverId = "http://ec2-18-191-123-240.us-east-2.compute.amazonaws.com:8080/"
    private var manager:SocketManager!
    private var socket: SocketIOClient!
    weak var delegate: SocketHelperDelegate? = nil
    
    //Connect socket
    func setupSocket() {
        manager = SocketManager(socketURL: URL(string: serverId)!, config: [.log(false), .compress, .forceWebsockets(true), .reconnects(true)])
        socket = manager.defaultSocket
        socket.connect()
        
        //Listen for events
        receiveMessage()
        newUserInRoom()
        playerLeftRoom()
        gameReady()
    }
    
    //Create profile with player name to get player id from server
    func createProfile(name: String, completion: @escaping (String)->()) {
        socket.on(clientEvent: .connect) {data, ack in
            let profileJSON: [String: Any] = ["player_name" : name]
            self.socket.emitWithAck("createProfile", profileJSON).timingOut(after: 0) { data in
                //Return player id in completion handler
                let profileInfo = data[0] as! [String: AnyObject]
                completion(profileInfo["player_id"] as! String)
            }
        }
    }
    
    //Send message to chat
    func sendMessage(name: String, message: String, gameId: String) {
        let msgJSON: [String : Any] = ["player_name" : name, "message" : message, "game_id": gameId]
        socket.emit("messageToServer", msgJSON)
    }
    
    func createGame(data: [String: String]) {
        socket.emit("createGame", data)
    }
}

//MARK: Events to listen to
fileprivate extension SocketHelper {
    func receiveMessage() {
        socket.on("messageToClient") {data, ack in
            self.delegate?.messageReceived()
        }
    }
    
    func newUserInRoom() {
        socket.on("newUserInGameRoom") {data, ack in
            
        }
    }
    
    func playerLeftRoom() {
        socket.on("playerLeaving") {data, ack in
            
        }
    }
    
    func gameReady() {
        socket.on("gameIsReady") {data, ack in
            
        }
    }
}
