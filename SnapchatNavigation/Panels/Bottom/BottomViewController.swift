//
//  BottomViewController.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 06/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

class BottomViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    weak var delegate: ButtonsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.layer.cornerRadius = backButton.frame.width/2
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.layer.borderWidth = 1
    }

    @IBAction func backToMainView(_ sender: UIButton) {
        delegate?.backToCamera()
    }
}
