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
        addSubview(profileButton)

        setNeedsUpdateConstraints()
    }
    
    var stackView: UIStackView!
    var delegate: HomeViewDelegate? = nil
    
    let joinButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Join", for: .normal)
        bt.addTarget(self, action: #selector(joinPressed), for: .touchDown)
        return bt
    }()
    
    let createButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Create", for: .normal)
        bt.addTarget(self, action: #selector(createPressed), for: .touchDown)
        return bt
    }()
    
    let rolesButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Roles", for: .normal)
        bt.addTarget(self, action: #selector(rolesPressed), for: .touchDown)
        return bt
    }()
    
    let profileButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(named: "ProfileButton"), for: .normal)
        bt.addTarget(self, action: #selector(profilePressed), for: .touchDown)
        return bt
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Mafia"
        lb.font = UIFont(name: "Magical Mystery Tour", size: 60)
        lb.textAlignment = .center
        lb.textColor = UIColor(rgb: 0xef6e31)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.layer.shadowRadius = 3
        lb.layer.shadowOpacity = 0.6
        lb.layer.shadowOffset = CGSize(width: 3, height: 3)
        lb.clipsToBounds = true
        return lb
    }()
    
    override func updateConstraints() {
        super.updateConstraints()
        let screenSize: CGRect = UIScreen.main.bounds
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: screenSize.height*0.25).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height*0.15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenSize.height*0.05).isActive = true
        
        createButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        joinButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        rolesButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        profileButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

//MARK: Touch events
extension HomeView {
    @objc func joinPressed() {
        animateButton(button: joinButton)
        delegate?.joinPressed()
    }
    
    @objc func createPressed() {
        animateButton(button: createButton)
        delegate?.createPressed()
    }
    
    @objc func rolesPressed() {
        animateButton(button: rolesButton)
        delegate?.rolesPressed()
    }
    
    @objc func profilePressed() {
        
    }
    
    private func animateButton(button: UIButton) {
        //Create bounce animation on button press
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            button.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
