//
//  PhoneDataController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol PhoneDataControllerDelegate : class {
    func sendPressed(withMessage message: String)
    func chatBackPressed()
    func scrollDidStop()
    func didSelectRowAt(indexPath: IndexPath)
}

class PhoneDataController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let chatCellId = "chatCellId"
    let playerListViewId = "PlayerListViewId"
    let cellId = "cellId"
    let screenSize = UIScreen.main.bounds
    
    lazy var playerTableDataController: PlayerTableDataController = {
        let playerTableDataController = PlayerTableDataController()
        playerTableDataController.delegate = self
        return playerTableDataController
    }()
    
    let chatBoxDataController = ChatBoxDataController()
    
    weak var delegate: PhoneDataControllerDelegate? = nil
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            //Player list view
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playerListViewId, for: indexPath) as! PlayerListView
            cell.playerTable.delegate = playerTableDataController
            cell.playerTable.dataSource = playerTableDataController
            cell.backgroundColor = .white
            return cell
        } else {
            //Chat log view
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatCellId, for: indexPath) as! ChatView
            cell.backgroundColor = UIColor.white
            cell.chatBox.dataSource = chatBoxDataController
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width*0.9 + 1, height: screenSize.height*0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //Disable phone scrolling if the current view is the player list
        delegate?.scrollDidStop()

    }
}

//MARK: Chat view delegate
extension PhoneDataController: ChatViewDelegate {
    func sendPressed(withMessage message: String) {
        delegate?.sendPressed(withMessage: message)
    }
    
    func chatBackPressed() {
        delegate?.chatBackPressed()
    }
}

extension PhoneDataController: PlayerTableDataControllerDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        delegate?.didSelectRowAt(indexPath: indexPath)
    }
}
