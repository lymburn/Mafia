//
//  GameController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-09.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        chatView.delegate = self
        chatView.dataSource = self
        chatView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        chatView.estimatedRowHeight = 100
        chatView.rowHeight = UITableViewAutomaticDimension
    }
    
    let screenSize: CGRect = UIScreen.main.bounds
    let cellId = "cellId"
    let messages = ["Te dolor saepe invenire mea, assum praesent qui in. Agam eleifend pericula qui eu, in vero praesent usu, malis prompta pericula id nam. Cu eros blandit recteque sea, perpetua constituam ea vix. Ubique legere aliquid ne his, modo dicunt omnium cum ea, et luptatum salutandi eum. At nam eripuit explicari liberavisse, id labores dolores oporteat has. No audire laoreet accusamus vis, an sumo vidisse eum, ut mei facer everti detraxit.", "I will save myself tonight cuz I think mafia will try to kill me.", "Screw you all"]
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Night"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.3
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let gameMenuBar: GameMenuBar = {
        let gm = GameMenuBar()
        gm.backgroundColor = .clear
        gm.translatesAutoresizingMaskIntoConstraints = false
        return gm
    }()
    
    let leftProfiles: ProfilesView = {
        let pv = ProfilesView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let rightProfiles: ProfilesView = {
        let pv = ProfilesView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let chatView: UITableView = {
        let cv = UITableView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.separatorColor = .clear
        cv.tableFooterView = UIView()
        cv.backgroundColor = .clear
        cv.layer.borderColor = UIColor.white.cgColor
        cv.layer.borderWidth = 2
        cv.layer.cornerRadius = 10
        return cv
    }()
    
    fileprivate func setupViews() {
        view.backgroundColor = UIColor(rgb: 0x181F42)
        view.addSubview(backgroundImage)
        view.addSubview(gameMenuBar)
        view.addSubview(leftProfiles)
        view.addSubview(rightProfiles)
        view.addSubview(chatView)
        self.updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        gameMenuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gameMenuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gameMenuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        gameMenuBar.heightAnchor.constraint(equalToConstant: screenSize.height*0.15).isActive = true
        
        leftProfiles.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftProfiles.topAnchor.constraint(equalTo: gameMenuBar.bottomAnchor).isActive = true
        leftProfiles.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        leftProfiles.widthAnchor.constraint(equalToConstant: screenSize.width*0.15).isActive = true
        
        rightProfiles.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rightProfiles.topAnchor.constraint(equalTo: gameMenuBar.bottomAnchor).isActive = true
        rightProfiles.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        rightProfiles.widthAnchor.constraint(equalToConstant: screenSize.width*0.15).isActive = true
        
        chatView.leadingAnchor.constraint(equalTo: leftProfiles.trailingAnchor, constant: 10).isActive = true
        chatView.trailingAnchor.constraint(equalTo: rightProfiles.leadingAnchor, constant: -10).isActive = true
        chatView.topAnchor.constraint(equalTo: gameMenuBar.bottomAnchor).isActive = true
        chatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
}

extension GameController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        cell.backgroundColor = .clear
        cell.messageTextView.text = messages[indexPath.row]
        return cell
    }
    
    
}

