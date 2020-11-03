//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by saber on 2020/10/29.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
        arc4random()
    }
    static func arc4random_color() -> UIColor {
        UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)), a: CGFloat(arc4random_uniform(256)))
    }
}
