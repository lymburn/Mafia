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
        socketHelper.setupSocket(name: "test", gameId: 123)
        tableView.register(LobbyCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let cellId = "cellId"
    let socketHelper = SocketHelper()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x181F42)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    let infoButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(named: "InfoButton"), for: .normal)
        return bt
    }()

    let tableView: UITableView = {
        let tb = UITableView()
        tb.rowHeight = 70
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.tableFooterView = UIView()
        tb.backgroundColor = .clear
        tb.separatorInset = UIEdgeInsets.zero
        tb.separatorColor = UIColor(rgb: 0xEDE1BE)
        return tb
    }()
    
    fileprivate func setupViews() {
        view.backgroundColor = UIColor(rgb: 0x181F42)
        view.addSubview(container)
        view.addSubview(tableView)
        container.addSubview(startButton)
        container.addSubview(exitButton)
        container.addSubview(infoButton)
        self.updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        let screenSize: CGRect = UIScreen.main.bounds
        
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: screenSize.height*0.15).isActive = true
        
        startButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        exitButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        infoButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
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

extension LobbyController {
    @objc func startPressed() {
        let game = GameController()
        game.socketHelper = socketHelper
        present(game, animated: true, completion: nil)
    }
}
