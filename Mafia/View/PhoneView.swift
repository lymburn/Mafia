//
//  PhoneView.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-13.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

//Base collection view cell for all phone views
class PhoneView: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let statusBar: StatusBar = {
        let sb = StatusBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
