//
//  UIScrollView.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 05/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

extension UIScrollView {

    static func make() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }


    static func makeHorizontal(with horizontalControllers: [UIViewController], in parent: UIViewController) -> UIScrollView {
        let scrollView = UIScrollView.make()

        func add(_ child: UIViewController, withOffset offset: CGFloat) {
            parent.addChild(child)
            scrollView.addSubview(child.view)
            child.didMove(toParent: parent)
            child.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                child.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                child.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                child.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: offset)
                ])
        }

        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        for (index, controller) in horizontalControllers.enumerated() {
            let xPosition = CGFloat(index) * width
            add(controller, withOffset: xPosition)
        }

        scrollView.contentSize = CGSize(width: width * CGFloat(horizontalControllers.count), height: height)
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: false)

        return scrollView
    }
}
