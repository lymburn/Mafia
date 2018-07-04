//
//  CreateController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-07.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class CreateController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    let createButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Create", for: .normal)
        bt.addTarget(self, action: #selector(createPressed), for: .touchDown)
        return bt
    }()

    override func updateViewConstraints() {
        super.updateViewConstraints()
        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        createButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

fileprivate extension CreateController {
    func setupViews() {
        view.backgroundColor = UIColor(rgb: 0x181F42)
        view.addSubview(createButton)
        view.setNeedsUpdateConstraints()
    }
}

extension CreateController {
    @objc func createPressed() {
        let lobby = LobbyController()
        present(lobby, animated: true, completion: nil)
    }
}
