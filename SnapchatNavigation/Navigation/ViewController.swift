//
//  ViewController.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 04/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

enum Panel {
    case top, bottom, left, center, camera, right
}

class ViewController: UIViewController {
    private var topContainer: UIView!
    private var centerContainer: UIView!
    private var scrollContainer: UIView!
    private var bottomContainer: UIView!

    private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        setupHorizontalViews()
        setupTopView()
        setupBottomView()
    }

    private func setupHorizontalViews() {
        centerContainer = UIView()
        view.addSubview(centerContainer)
        centerContainer.fit(to: view)
        centerContainer.clipsToBounds = true
        let centerController = CenterViewController()
        addChild(centerController, toContainer: centerContainer)

        scrollContainer = UIView()
        view.addSubview(scrollContainer)
        scrollContainer.fit(to: view)

        let rightController = RightViewController()
        let panController = PanController()
        panController.delegate = self
        let leftController = LeftViewController()

        let horizontalControllers = [
            leftController,
            panController,
            rightController
        ]

        scrollView = UIScrollView.makeHorizontal(with: horizontalControllers, in: self)
        scrollContainer.addSubview(scrollView)
        scrollView.fit(to: scrollContainer)
    }

    private func setupTopView() {
        topContainer = UIView()
        view.insertSubview(topContainer, belowSubview: centerContainer)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topContainer.heightAnchor.constraint(equalTo: view.heightAnchor),
            topContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            topContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topContainer.bottomAnchor.constraint(equalTo: view.centerYAnchor)
            ])

        let topController = TopViewController()
        addChild(topController, toContainer: topContainer)
    }

    private func setupBottomView() {
        bottomContainer = UIView()
        view.insertSubview(bottomContainer, aboveSubview: scrollView)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomContainer.heightAnchor.constraint(equalTo: view.heightAnchor),
            bottomContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomContainer.topAnchor.constraint(equalTo: view.bottomAnchor)
            ])


        let bottomController = BottomViewController()
        addChild(bottomController, toContainer: bottomContainer)
    }
}

extension ViewController: PanControllerDelegate {
    func present(_ panel: Panel) {
        switch panel {
        case .bottom:
            bottomContainer.center = view.center
            scrollView.center.y = view.center.y - view.frame.height
            centerContainer.center.y = view.center.y - view.frame.height
        case .top:
            topContainer.center = view.center
            scrollView.center.y = view.center.y + view.frame.height
            centerContainer.center.y = view.center.y + view.frame.height
        default:
            scrollContainer.center = view.center
            centerContainer.center = scrollContainer.center
            bottomContainer.center.y = view.center.y + view.frame.height
            topContainer.center.y = view.center.y - (view.frame.height/2)
        }
    }

    func view(_ panel: Panel) -> UIView {
        switch panel {
        case .center: return scrollContainer
        case .top: return topContainer
        case .bottom: return bottomContainer
        default: return centerContainer
        }
    }
}
