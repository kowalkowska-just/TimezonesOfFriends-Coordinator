//
//  ColorRGB.swift
//  TimezonesOfFriends-Coordinator
//
//  Created by Justyna Kowalkowska on 11/02/2021.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat?) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha ?? 1.0)
    }
    
    static let lightRedColor = rgb(red: 240, green: 128, blue: 128, alpha: 0.4)
}
