//
//  HomeViewButtons.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-07.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class HomeViewButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        self.setTitleColor(UIColor(rgb: 0xEDE1BE), for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2/UIScreen.main.nativeScale
        self.contentEdgeInsets = UIEdgeInsetsMake(4, 20, 4, 20)
        self.layer.borderColor = UIColor(rgb: 0xEDE1BE).cgColor
        
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
