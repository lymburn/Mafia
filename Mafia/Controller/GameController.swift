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

    }
    
    let screenSize: CGRect = UIScreen.main.bounds
    let cellId = "cellId"
    let chatCellId = "chatCellId"
    let backgroundCellId = "backgroundCellId"
    var messages = [Message]()
    var socketHelper: SocketHelper!
    
    let cardsCollectionView: UICollectionView = {
        let frame = CGRect(x: 25, y: 50, width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.8)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let col = UICollectionView(frame: frame, collectionViewLayout: layout)
        col.layer.borderColor = UIColor.red.cgColor
        col.layer.borderWidth = 1.0
        col.backgroundColor = UIColor.yellow
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
        view.backgroundColor = UIColor(rgb: 0x181F42)
                view.addSubview(cardsCollectionView)
        view.addSubview(backgroundCollectionView)

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
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.cardsCollectionView {
            return CGSize(width: cardsCollectionView.frame.width*3, height: cardsCollectionView.frame.height)
        } else {
            return CGSize(width: backgroundCollectionView.frame.width*3, height: backgroundCollectionView.frame.height)
        }
    }
}

extension GameController: SocketHelperDelegate {
    func messageReceived() {
        let message = socketHelper.getMessage()
        messages.append(message)
    }
}


