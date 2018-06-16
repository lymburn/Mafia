//
//  NotificationDataController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class NotificationDataController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let screenSize = UIScreen.main.bounds
    let notificationCellId = "notificationCellId"
    let clearNotificationCellId = "clearNotificationCellId"
    
    let newsTableDataController = NewsTableDataController()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notificationCellId, for: indexPath) as! NotificationView
            cell.backgroundColor = .black
            cell.newsTable.delegate = newsTableDataController
            cell.newsTable.dataSource = newsTableDataController
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: clearNotificationCellId, for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width*0.9 + 1, height: screenSize.height*0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
