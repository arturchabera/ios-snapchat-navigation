//
//  UIViewController.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 06/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChild(_ controller: UIViewController, toContainer container: UIView) {
        guard let subView = controller.view else { return }
        addChild(controller)
        container.addSubview(subView)
        controller.didMove(toParent: self)
        subView.fit(to: container)
        container.clipsToBounds = true
    }
}
