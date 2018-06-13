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
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        cardsCollectionView.register(ChatViewCell.self, forCellWithReuseIdentifier: chatCellId)
        cardsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "hi")
        
        backgroundCollectionView.delegate = self
        backgroundCollectionView.dataSource = self
        backgroundCollectionView.register(BackgroundCell.self, forCellWithReuseIdentifier: backgroundCellId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    let screenSize: CGRect = UIScreen.main.bounds
    let cellId = "cellId"
    let chatCellId = "chatCellId"
    let backgroundCellId = "backgroundCellId"
    var messages = [Message]()
    var socketHelper: SocketHelper!
    
    let cardsCollectionView: UICollectionView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let frame = CGRect(x: screenSize.width*0.05, y: screenSize.height, width: screenSize.width*0.9, height: screenSize.height*0.8)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let col = UICollectionView(frame: frame, collectionViewLayout: layout)
        col.backgroundColor = .clear
        col.translatesAutoresizingMaskIntoConstraints = false
        return col
    }()
    
    let backgroundCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        return col
    }()
    
    fileprivate func setupViews() {
        view.addSubview(backgroundCollectionView)
        view.addSubview(cardsCollectionView)
        self.updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        backgroundCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: Table view delegate and data source
extension GameController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        //cell.backgroundColor = .clear
        //cell.messageTextView.text = messages[indexPath.row].content
        //cell.name.text = messages[indexPath.row].sender
        return cell
    }
}

//MARK: Collection views delegate and data source
extension GameController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cardsCollectionView {
            return 3
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cardsCollectionView {
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatCellId, for: indexPath) as! ChatViewCell
                cell.chatBox.delegate = self
                cell.chatBox.dataSource = self
                cell.chatBox.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
                cell.backgroundColor = .white
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hi", for: indexPath)
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: backgroundCellId, for: indexPath) as! BackgroundCell
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.cardsCollectionView {
            return CGSize(width: cardsCollectionView.frame.width, height: cardsCollectionView.frame.height)
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

extension GameController: BackgroundCellDelegate {
    func swipedUp() {
        //Slide in cards from bottom
        let origin: CGFloat = screenSize.height*0.15
        UIView.animate(withDuration: 0.35) {
            self.cardsCollectionView.frame.origin.y = origin
        }
    }
}

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


