//
//  GameController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-09.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import SocketIO

class GameController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addSwipeDownGesture()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        //Round corners for only top
        statusBar.round(corners: [.topRight, .topLeft], radius: 15)
        notificationCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .bottom, animated: false)
    }
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    let cellId = "cellId"
    let chatCellId = "chatCellId"
    let playerListViewId = "PlayerListViewId"
    let notificationCellId = "notificationCellId"
    let backgroundCellId = "backgroundCellId"
    let clearNotificationCellId = "clearNotificationCellId"
    var messages = [Message]()
    
    lazy var phoneCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.backgroundColor = UIColor.white
        col.translatesAutoresizingMaskIntoConstraints = false
        col.showsHorizontalScrollIndicator = false
        col.isScrollEnabled = false
        col.layer.cornerRadius = 15
        col.isPagingEnabled = true
        
        col.delegate = self.phoneDataController
        col.dataSource = self.phoneDataController
        col.register(ChatView.self, forCellWithReuseIdentifier: chatCellId)
        col.register(PlayerListView.self, forCellWithReuseIdentifier: playerListViewId)
        return col
    }()
    
    lazy var phoneDataController: PhoneDataController = {
        let phoneDataController = PhoneDataController()
        phoneDataController.delegate = self
        return phoneDataController
    }()
    
    let statusBar: StatusBar = {
        let sb = StatusBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    lazy var notificationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.backgroundColor = .clear
        col.translatesAutoresizingMaskIntoConstraints = false
        col.showsVerticalScrollIndicator = false
        col.layer.cornerRadius = 15
        col.isPagingEnabled = true
        col.alpha = 0
        col.bounces = false
        
        col.delegate = self.notificationDataController
        col.dataSource = self.notificationDataController
        col.register(UICollectionViewCell.self, forCellWithReuseIdentifier: clearNotificationCellId)
        col.register(NotificationView.self, forCellWithReuseIdentifier: notificationCellId)
        return col
    }()
    
    lazy var notificationDataController: NotificationDataController = {
        let notificationDataController = NotificationDataController()
        notificationDataController.delegate = self
        return notificationDataController
    }()
    
    lazy var backgroundCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.showsHorizontalScrollIndicator = false
        
        col.register(BackgroundView.self, forCellWithReuseIdentifier: backgroundCellId)
        col.delegate = self.backgroundDataController
        col.dataSource = self.backgroundDataController
        return col
    }()
    
    lazy var backgroundDataController: BackgroundDataController = {
        let backgroundDataController = BackgroundDataController()
        backgroundDataController.delegate = self
        return backgroundDataController
    }()
    
    lazy var targetsDataController: TargetsDataController = {
        let targetsDataController = TargetsDataController()
        return targetsDataController
    }()
    
    lazy var targetListView: TargetListView = {
        let view = TargetListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.targetListTable.dataSource = self.targetsDataController
        view.targetListTable.delegate = self.targetsDataController
        return view
    }()
    
    let targetActionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Target"), for: .normal)
        button.addTarget(self, action: #selector(targetPressed), for: .touchDown)
        return button
    }()
    
    fileprivate func addSwipeDownGesture() {
        //Swipe down gesture for status bar
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(swipedDown))
        tap.minimumPressDuration = 0
        statusBar.addGestureRecognizer(tap)
    }
    
    fileprivate func setupViews() {
        view.addSubview(backgroundCollectionView)
        view.addSubview(targetActionButton)
        view.addSubview(targetListView)
        view.addSubview(phoneCollectionView)
        view.addSubview(statusBar)
        view.addSubview(notificationCollectionView)
        self.updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        backgroundCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        targetActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenSize.width*0.1).isActive = true
        targetActionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height*0.2).isActive = true
        targetActionButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        targetActionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        targetListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenSize.width*0.05 - 1).isActive = true
        targetListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenSize.width*0.05).isActive = true
        targetListView.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height).isActive = true
        targetListView.heightAnchor.constraint(equalToConstant: screenSize.height*0.9).isActive = true
        
        phoneCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenSize.width*0.05 - 1).isActive = true
        phoneCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenSize.width*0.05).isActive = true
        phoneCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height).isActive = true
        phoneCollectionView.heightAnchor.constraint(equalToConstant: screenSize.height*0.9).isActive = true
        
        notificationCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenSize.width*0.05 - 1).isActive = true
        notificationCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenSize.width*0.05).isActive = true
        notificationCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height*0.05).isActive = true
        notificationCollectionView.heightAnchor.constraint(equalToConstant: screenSize.height*0.9 + 1).isActive = true
        
        statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenSize.width*0.05 - 1).isActive = true
        statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenSize.width*0.05).isActive = true
        statusBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        statusBar.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height).isActive = true
    }
}

//MARK: Socket delegate
extension GameController: SocketHelperDelegate {
    func messageReceived() {
        let message = SocketHelper.shared.getMessage()
        messages.append(message)
    }
}

//MARK: Background delegate methods
extension GameController: BackgroundDataControllerDelegate {
    func swipedUp() {
        //Slide in phone from bottom
        UIView.animate(withDuration: 0.5) {
            self.phoneCollectionView.transform = CGAffineTransform(translationX: 0, y: -self.screenSize.height*0.95)
            self.statusBar.transform = CGAffineTransform(translationX: 0, y: -self.screenSize.height*0.95)
        }
    }
}

//MARK: Phone collection view delegate methods
extension GameController: PhoneDataControllerDelegate {
    func sendPressed(withMessage message: String) {
        SocketHelper.shared.sendMessage(name: "Eugene", message: message, gameId: "Plsbegq")
    }
    
    func chatBackPressed() {
        phoneCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        phoneCollectionView.isScrollEnabled = false
    }
    
    func scrollDidStop() {
        let indexPaths = phoneCollectionView.indexPathsForVisibleItems
        let currentIndexPath = indexPaths[0]
        phoneCollectionView.isScrollEnabled = currentIndexPath.item == 0 ? false : true
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        phoneCollectionView.isScrollEnabled = true
        phoneCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
    }
}

//MARK: Notiification data controller delegate methods
extension GameController: NotificationDataControllerDelegate {
    func didScroll(scrollView: UIScrollView) {
        //Determine whether notification view is active
        let center = CGPoint(x: (scrollView.frame.width/2) , y: scrollView.contentOffset.y + (scrollView.frame.height / 2))
        if let indexPath = notificationCollectionView.indexPathForItem(at: center) {
            if indexPath.row == 1 {
                notificationCollectionView.alpha = 0
            }
        }
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

//MARK: Touch events
extension GameController {
    //Status bar swipe down gesture
    @objc func swipedDown() {
        notificationCollectionView.alpha = 1
        notificationCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    //Target action pressed
    @objc func targetPressed() {
        //Slide in target list from bottom
        UIView.animate(withDuration: 0.5) {
            self.targetListView.transform = CGAffineTransform(translationX: 0, y: -self.screenSize.height*0.95)
        }
    }
}


