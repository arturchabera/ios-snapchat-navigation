//
//  UIScrollView.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 05/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

extension UIScrollView {
    static func makeHorizontalFlow(with horizontalControllers: [UIViewController], in parent: UIViewController) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        for controller in horizontalControllers.enumerated() {
            let xPosition = CGFloat(controller.offset) * width
            parent.addChild(controller.element)
            scrollView.addSubview(controller.element.view)
            controller.element.didMove(toParent: parent)
            controller.element.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                controller.element.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                controller.element.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                controller.element.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: xPosition)
                ])
        }

        scrollView.contentSize = CGSize(width: width * CGFloat(horizontalControllers.count), height: height)
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: false)

        return scrollView
    }
}
