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

    let startButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Start", for: .normal)
        bt.addTarget(self, action: #selector(startPressed), for: .touchDown)
        return bt
    }()

    override func updateViewConstraints() {
        super.updateViewConstraints()
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

fileprivate extension CreateController {
    func setupViews() {
        view.backgroundColor = UIColor(rgb: 0x181F42)
        view.addSubview(startButton)
        view.setNeedsUpdateConstraints()
    }
}

extension CreateController {
    @objc func startPressed() {
    
    }
}
