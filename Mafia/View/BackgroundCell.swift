//
//  BackgroundCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-12.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class BackgroundCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeUp.direction = .up
        backgroundImage.addGestureRecognizer(swipeUp)
    }
    
    @objc func swipedUp() {
        print("swiped")
    }

    let backgroundImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Day copy"))
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate func setupViews() {
        addSubview(backgroundImage)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
