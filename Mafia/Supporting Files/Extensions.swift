//
//  Extensions.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-06-07.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

extension UIColor {
    func rgb(_ red: Double, _ green: Double, _ blue: Double, _ alpha: Double) -> UIColor {
        return UIColor.init(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: alpha)
    }
}
