//
//  BackgroundCell.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-12.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol BackgroundViewDelegate: class {
    func swipedUp()
}

class BackgroundView: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeUp.direction = .up
        backgroundImage.addGestureRecognizer(swipeUp)
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {(tiner) in
            UIView.animate(withDuration:2.0, animations: {
                self.sky.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                self.backgroundColor = UIColor(rgb: 0x011724)
            })
            
            UIView.transition(with: self.backgroundImage, duration: 2.0, options: .transitionCrossDissolve, animations: {
                self.backgroundImage.image = UIImage(named: "Night")
            })
        }
    }
    
    weak var delegate: BackgroundViewDelegate? = nil
    
    @objc func swipedUp() {
        delegate?.swipedUp()
    }

    let backgroundImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Day"))
        iv.clipsToBounds = true
        iv.contentMode = .bottom
        iv.isUserInteractionEnabled = true
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
    
    fileprivate func setupViews() {
        backgroundColor = UIColor(rgb: 0x85E4FE)
        addSubview(sky)
        addSubview(backgroundImage)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        sky.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sky.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sky.centerYAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
