//
//  JoinAlertView.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-07.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class JoinContainer: BaseView {
    override func setupViews() {
        backgroundColor = UIColor.clear
        //addSubview(iconImage)
        addSubview(joinButton)
        updateConstraints()
        //setContainer()
    }
    
    override func layoutSubviews() {
        //layoutIconImage()
        //layoutContainer()
    }
    
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 2
        iv.clipsToBounds = true
        return iv
    }()
    
    let joinButton: HomeViewButton = {
        let bt = HomeViewButton()
        bt.setTitle("Join", for: .normal)
        return bt
    }()
    
    override func updateConstraints() {
        super.updateConstraints()
        /*
        iconImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: bounds.width/3).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: bounds.width/3).isActive = true
        iconImage.topAnchor.constraint(equalTo: topAnchor, constant: -20).isActive = true
        */
        joinButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        joinButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        joinButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        joinButton.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
    }
}

fileprivate extension JoinContainer {
    func setContainer() {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.black.cgColor
        shape.backgroundColor = UIColor.black.cgColor
        layer.insertSublayer(shape, at: 0)
    }
    
    func layoutIconImage() {
        //iconImage.layer.cornerRadius = iconImage.frame.width/2
    }
    
    func layoutContainer() {
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 0)
        let layer = self.layer.sublayers?.first
        layer?.shadowPath = path.cgPath
    }
}
