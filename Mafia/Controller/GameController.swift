//
//  GameController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-09.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import SocketIO

class GameController: UIViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        socketHelper.delegate = self
        
        phoneCollectionView.delegate = self
        phoneCollectionView.dataSource = self
        phoneCollectionView.register(ChatView.self, forCellWithReuseIdentifier: chatCellId)
        phoneCollectionView.register(PlayerListView.self, forCellWithReuseIdentifier: playerListViewId)
        
        backgroundCollectionView.delegate = self
        backgroundCollectionView.dataSource = self
        backgroundCollectionView.register(BackgroundCell.self, forCellWithReuseIdentifier: backgroundCellId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        //Round corners for only top
        statusBar.round(corners: [.topRight, .topLeft], radius: 15)
    }
    
    let screenSize: CGRect = UIScreen.main.bounds
    let cellId = "cellId"
    let chatCellId = "chatCellId"
    let playerListViewId = "PlayerListViewId"

    let backgroundCellId = "backgroundCellId"
    var messages = [Message]()
    var socketHelper: SocketHelper!
    
    let phoneCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.backgroundColor = UIColor.white
        col.translatesAutoresizingMaskIntoConstraints = false
        col.showsHorizontalScrollIndicator = false
        col.layer.cornerRadius = 15
        return col
    }()
    
    let statusBar: StatusBar = {
        let sb = StatusBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    let backgroundCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.showsHorizontalScrollIndicator = false
        return col
    }()
    
    fileprivate func setupViews() {
        view.addSubview(backgroundCollectionView)
        view.addSubview(phoneCollectionView)
        view.addSubview(statusBar)
        self.updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        backgroundCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        phoneCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenSize.width*0.05).isActive = true
        phoneCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenSize.width*0.05).isActive = true
        phoneCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height).isActive = true
        phoneCollectionView.heightAnchor.constraint(equalToConstant: screenSize.height*0.9).isActive = true
        
        statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenSize.width*0.05 - 1).isActive = true
        statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenSize.width*0.05).isActive = true
        statusBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        statusBar.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height).isActive = true
    }
}

//MARK: Table view data source for the chat log
extension GameController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        cell.backgroundColor = .clear
        //cell.messageTextView.text = messages[indexPath.row].content
        //cell.name.text = messages[indexPath.row].sender
        return cell
    }
}

//MARK: Table view delegate methods for managing the player list
extension GameController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: Collection views delegate and data source
extension GameController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.phoneCollectionView ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.phoneCollectionView {
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playerListViewId, for: indexPath) as! PlayerListView
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatCellId, for: indexPath) as! ChatView
                cell.chatBox.delegate = self
                cell.chatBox.dataSource = self
                cell.chatBox.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
                cell.backgroundColor = UIColor(rgb: 0xF5F6FA)
                return cell
            }
            
        } else {
            //Background view
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: backgroundCellId, for: indexPath) as! BackgroundCell
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.phoneCollectionView {
            return CGSize(width: phoneCollectionView.frame.width, height: phoneCollectionView.frame.height)
        } else {
            let multiplier = 1281/backgroundCollectionView.frame.width
            return CGSize(width: backgroundCollectionView.frame.width*multiplier, height: backgroundCollectionView.frame.height)
        }
    }
}

extension GameController: SocketHelperDelegate {
    func messageReceived() {
        let message = socketHelper.getMessage()
        messages.append(message)
    }
}

//MARK: Background delegate methods
extension GameController: BackgroundCellDelegate {
    func swipedUp() {
        //Slide in phone from bottom
        UIView.animate(withDuration: 0.5) {
            self.phoneCollectionView.transform = CGAffineTransform(translationX: 0, y: -self.screenSize.height*0.95)
            self.statusBar.transform = CGAffineTransform(translationX: 0, y: -self.screenSize.height*0.95)
        }
    }
}

extension GameController: ChatViewDelegate {
    func sendPressed(message: String) {
        //socketHelper.sendMessage(name: "Eugene", message: message, gameId: 123)
    }
}

//MARK: View management methods for the keyboard
extension GameController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}


