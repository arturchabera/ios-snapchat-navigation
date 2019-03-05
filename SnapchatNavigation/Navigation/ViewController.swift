//
//  ViewController.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 04/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        let rightPanel = RightViewController()
        let centerPanel = CenterViewController()
        let leftPanel = LeftViewController()

        scrollView = UIScrollView.makeHorizontal(
            with: [leftPanel, centerPanel, rightPanel],
            in: self
        )
        view.addSubview(scrollView)
        scrollView.fit(to: view)
    }

}

