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
        backgroundColor = UIColor(rgb: 0x85E4FE)
        //Setup stack view
        stackView = UIStackView(arrangedSubviews: [joinButton, createButton, rolesButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(sky)
        addSubview(backgroundImage)
        addSubview(titleLabel)
        addSubview(stackView)
        
        updateConstraints()
        
        transitionSky()
    }
    
    var stackView: UIStackView!
    weak var delegate: HomeViewDelegate? = nil
    
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
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Mafia"
        lb.font = UIFont(name: "Magical Mystery Tour", size: 60)
        lb.textAlignment = .center
        lb.textColor = UIColor.white
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.layer.shadowRadius = 3
        lb.layer.shadowOpacity = 0.6
        lb.layer.shadowOffset = CGSize(width: 3, height: 3)
        lb.clipsToBounds = true
        return lb
    }()
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Day"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let sky: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Sky"))
        iv.clipsToBounds = true
        iv.contentMode = .center
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func updateConstraints() {
        super.updateConstraints()
        let screenSize: CGRect = UIScreen.main.bounds
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: screenSize.height*0.05).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: screenSize.height*0.2).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenSize.height*0.15).isActive = true
        
        createButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        joinButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        rolesButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        sky.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sky.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sky.centerYAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    //Repeatedly transition the sky between day and night
    private func transitionSky() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {(timer) in
            //If sky is day, transition to night. Else, transition to day
            let skyColor = self.backgroundColor == UIColor(rgb: 0x85E4FE) ? UIColor(rgb: 0x011724) : UIColor(rgb: 0x85E4FE)
            let skyImage = self.backgroundImage.image == UIImage(named: "Day") ? UIImage(named: "Night") : UIImage(named: "Day")
            let rotationAngle = self.backgroundImage.image == UIImage(named: "Day") ? CGFloat.pi : 2*CGFloat.pi
            
            UIView.animate(withDuration:2.0, animations: {
                self.sky.transform = CGAffineTransform(rotationAngle: rotationAngle)
                self.backgroundColor = skyColor
            })
            
            UIView.transition(with: self.backgroundImage, duration: 2.0, options: .transitionCrossDissolve, animations: {
                self.backgroundImage.image = skyImage
            })
        }
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
    
    private func animateButton(button: UIButton) {
        //Create bounce animation on button press
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            button.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
