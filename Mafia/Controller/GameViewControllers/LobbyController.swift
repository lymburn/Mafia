//
//  LobbyController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-07.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class LobbyController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        SocketHelper.shared.setupSocket(name: "test", gameId: gameId)
        chatBox.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        chatBox.delegate = self
        chatBox.dataSource = self
        
        fetchGameData()
    }
    
    let cellId = "cellId"
    var gameId: String!
    var messageViewModels = [MessageViewModel]()
    
    let startButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Start", for: .normal)
        bt.titleLabel?.font = UIFont(name: "Magical Mystery Tour", size: 45)
        bt.addTarget(self, action: #selector(startPressed), for: .touchDown)
        return bt
    }()
    
    let exitButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(named: "ExitButton"), for: .normal)
        return bt
    }()

    let chatBox: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.allowsSelection = false
        tv.tableFooterView = UIView()
        tv.backgroundColor = .clear
        return tv
    }()
    
    let keyboardView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Helvetica", size: 20)
        textView.textColor = UIColor(rgb: 0x718093)
        textView.text = "Type your message here..."
        textView.clipsToBounds = true
        textView.backgroundColor = UIColor(rgb: 0xdcdde1)
        textView.isScrollEnabled = false
        textView.returnKeyType = UIReturnKeyType.send
        textView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 5, right: 8)
        
        return textView
    }()
    
    fileprivate func setupViews() {
        view.backgroundColor = UIColor(rgb: 0x181F42)
        view.addSubview(chatBox)
        view.addSubview(keyboardView)
        self.updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        chatBox.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chatBox.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chatBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        chatBox.bottomAnchor.constraint(equalTo: keyboardView.topAnchor, constant: -8).isActive = true
        
        keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        keyboardView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension LobbyController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
}

fileprivate extension LobbyController {
    func fetchGameData() {
        Service.shared.fetchChatHistory(gameId: gameId) { (messages, error) in
            if let err = error {
                print(err)
                return
            }

            self.messageViewModels = messages?.map({return MessageViewModel(message: $0)}) ?? []
        }
    }
}

extension LobbyController {
    @objc func startPressed() {
        let game = GameController()
        present(game, animated: true, completion: nil)
    }
}
