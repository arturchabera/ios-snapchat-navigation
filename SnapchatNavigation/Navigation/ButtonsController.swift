//
//  ButtonsController.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 08/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

protocol ButtonsDelegate: class {
    func scroll(to panel: Panel)
}

class ButtonsController: UIViewController {

    weak var delegate: ButtonsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
