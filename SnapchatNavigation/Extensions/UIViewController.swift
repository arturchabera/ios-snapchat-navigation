//
//  UIViewController.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 05/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

extension UIViewController {
    private func setupConstraints(for childController: UIViewController, in scrollView: UIScrollView, xPosition: CGFloat) {
        childController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            childController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            childController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: xPosition)
            ])
    }
}
