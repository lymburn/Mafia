//
//  HomeView.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-07.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol HomeViewDelegate: class {
    func joinPressed()
    func createPressed()
    func rolesPressed()
}

class HomeView: BaseView {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        //Setup stack view
        stackView = UIStackView(arrangedSubviews: [joinButton, createButton, rolesButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(stackView)

        setNeedsUpdateConstraints()
    }
    
    var stackView: UIStackView!
    var delegate: HomeViewDelegate? = nil
    
    let joinButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Join Game", for: .normal)
        bt.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(joinPressed), for: .touchDown)
        return bt
    }()
    
    let createButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Create Game", for: .normal)
        bt.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(joinPressed), for: .touchDown)
        return bt
    }()
    
    let rolesButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Game Roles", for: .normal)
        bt.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(joinPressed), for: .touchDown)
        return bt
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Mafia"
        lb.font = UIFont(name: "Helvetica", size: 35)
        lb.textAlignment = .center
        lb.textColor = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override func updateConstraints() {
        super.updateConstraints()
        let screenSize: CGRect = UIScreen.main.bounds
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height*0.2).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

//MARK: Touch events
extension HomeView {
    @objc func joinPressed() {
        delegate?.joinPressed()
    }
    
    @objc func createPressed() {
        delegate?.createPressed()
    }
    
    @objc func rolesPressed() {
        delegate?.rolesPressed()
    }
}
