//
//  UIColor.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 11/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

extension UIColor {
    var components: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        guard let components = cgColor.components else { fatalError("invalid color declaration") }
        if cgColor.numberOfComponents == 2 {
            return (r: components[0], g: components[0], b: components[0], a: components[1])
        } else {
            return (r: components[0], g: components[1], b: components[2], a: components[3])
        }
    }

    static func transition(from startColor: UIColor, to endColor: UIColor, with offset: CGFloat) -> UIColor {
        let red = (1 - offset) * startColor.components.r + offset * endColor.components.r
        let green = (1 - offset) * startColor.components.g + offset * endColor.components.g
        let blue = (1 - offset) * startColor.components.b + offset * endColor.components.b
        let alpha = (1 - offset) * startColor.components.a + offset * endColor.components.a

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
