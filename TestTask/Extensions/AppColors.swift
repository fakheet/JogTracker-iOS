//
//  AppColors.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

extension UIColor {
    static let appGreen = UIColor(red: 131, green: 200, blue: 58)
    static let appDarkGreen = UIColor(red: 101, green: 157, blue: 44)
    
    static let appPurple = UIColor(red: 219, green: 140, blue: 243)
    
    static let appGrey = UIColor(red: 166, green: 161, blue: 161)
    static let appDarkGrey = UIColor(red: 61, green: 59, blue: 62)

    convenience init(red: Int, green: Int, blue: Int, a: Int = 255) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
}
