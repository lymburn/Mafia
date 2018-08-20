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
        
        SocketHelper.shared.setupSocket()
        SocketHelper.shared.createProfile(name: "Eugene")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    var stackView: UIStackView!

    let createButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Create", for: .normal)
        bt.addTarget(self, action: #selector(createPressed), for: .touchDown)
        return bt
    }()
    
    let mafiaTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Number of Mafias"
        tf.textAlignment = .center
        tf.textColor = .white
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let detectiveTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Number of Detectives"
        tf.textAlignment = .center
        tf.textColor = .white
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let guardianTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Number of Guardians"
        tf.textAlignment = .center
        tf.textColor = .white
        tf.keyboardType = .numberPad
        return tf
    }()

    override func updateViewConstraints() {
        super.updateViewConstraints()
        let screenSize = UIScreen.main.bounds
        
        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        createButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16).isActive = true
        createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: screenSize.height*0.2).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -screenSize.height*0.4).isActive = true
    }
}

fileprivate extension CreateController {
    func setupViews() {
        view.backgroundColor = UIColor(rgb: 0x85E4FE)
        view.addSubview(createButton)
        //Set up stack view
        stackView = UIStackView(arrangedSubviews: [mafiaTextField, detectiveTextField, guardianTextField])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.setNeedsUpdateConstraints()
    }
}

extension CreateController {
    @objc func createPressed() {
        let lobby = LobbyController()
        present(lobby, animated: true, completion: nil)
    }
}
