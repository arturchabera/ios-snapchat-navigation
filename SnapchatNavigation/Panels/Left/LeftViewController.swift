//
//  LeftViewController.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 05/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        containerView.layer.cornerRadius = Layout.containerCornerRadius
        containerView.clipsToBounds = true
    }
}
