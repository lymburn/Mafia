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
    }
    
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
    
    fileprivate func setupViews() {
        view.backgroundColor = UIColor(rgb: 0x181F42)
        view.addSubview(backgroundImage)
        view.addSubview(gameMenuBar)
        view.addSubview(leftProfiles)
        view.addSubview(rightProfiles)
        self.updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        let screenSize: CGRect = UIScreen.main.bounds
        
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
        leftProfiles.widthAnchor.constraint(equalToConstant: screenSize.width*0.2).isActive = true
        
        rightProfiles.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rightProfiles.topAnchor.constraint(equalTo: gameMenuBar.bottomAnchor).isActive = true
        rightProfiles.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        rightProfiles.widthAnchor.constraint(equalToConstant: screenSize.width*0.2).isActive = true
    }
}

