//
//  StatusBar.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-13.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class StatusBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let batteryIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Battery"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let wifiIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Wifi"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let connectionIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Connection"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "1:50 PM"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    fileprivate func setupViews() {
        backgroundColor = .black
        addSubview(connectionIcon)
        addSubview(wifiIcon)
        addSubview(batteryIcon)
        addSubview(timeLabel)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        connectionIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        connectionIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        connectionIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        connectionIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        wifiIcon.leadingAnchor.constraint(equalTo: connectionIcon.trailingAnchor, constant: 8).isActive = true
        wifiIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        wifiIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        wifiIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true

        batteryIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        batteryIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        batteryIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        batteryIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true

        timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
