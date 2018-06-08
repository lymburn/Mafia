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
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "game id"
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 2
        tf.textAlignment = .center
        tf.textColor = .white
        return tf
    }()
    
    let joinButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Create", for: .normal)
        bt.addTarget(self, action: #selector(joinPressed), for: .touchDown)
        return bt
    }()

    override func updateViewConstraints() {
        super.updateViewConstraints()
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}

fileprivate extension JoinController {
    func setupViews() {
        view.backgroundColor = UIColor(rgb: 0x181F42)
        view.addSubview(textField)
        view.setNeedsUpdateConstraints()
    }
}

extension JoinController {
    @objc func joinPressed() {
        
    }
}


