//
//  UIView.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 05/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

extension UIView {
    func fit(to container: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            topAnchor.constraint(equalTo: container.topAnchor),
            bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
    }
}
