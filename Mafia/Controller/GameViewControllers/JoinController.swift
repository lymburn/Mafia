//
//  JoinController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-07.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class JoinController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textField.setBottomBorder(color: .white)
    }
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Game ID"
        tf.textAlignment = .center
        tf.textColor = .white
        return tf
    }()
    
    let joinButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Join", for: .normal)
        bt.addTarget(self, action: #selector(joinPressed), for: .touchDown)
        bt.setTitleColor(.white, for: .normal)
        return bt
    }()

    override func updateViewConstraints() {
        super.updateViewConstraints()
        let screenSize = UIScreen.main.bounds
        
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenSize.width*0.2).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenSize.width*0.2).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        joinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        joinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        joinButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32).isActive = true
    }
    
}

fileprivate extension JoinController {
    func setupViews() {
        view.backgroundColor = UIColor(rgb: 0x85E4FE)
        view.addSubview(textField)
        view.addSubview(joinButton)
        view.setNeedsUpdateConstraints()
    }
}

extension JoinController {
    @objc func joinPressed() {
        
    }
}


