//
//  UIButton.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 11/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

extension UIButton {
    static func make(_ side: Panel) -> UIButton {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = Layout.sideButtonHeight/2
        button.backgroundColor = .white
        var buttonHeight: CGFloat!
        switch side {
        case .left, .right:
            button.layer.cornerRadius = Layout.sideButtonHeight/2
            buttonHeight = Layout.sideButtonHeight
        case .center:
            button.layer.cornerRadius = Layout.centralButtonHeight/2
            buttonHeight = Layout.centralButtonHeight
        default: break
        }

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: buttonHeight),
            button.widthAnchor.constraint(equalToConstant: buttonHeight),
            ])
        return button
    }
}
