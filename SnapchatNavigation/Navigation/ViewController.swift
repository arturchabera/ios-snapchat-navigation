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
    private var buttonsContainer: UIView!
    private var buttonsController: ButtonsController!

    private var scrollView: UIScrollView!
    private var shouldAnimate: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        setupHorizontalViews()
        setupTopView()
        setupBottomView()
        setupButtonsContainer()
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
        scrollView.delegate = self
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
        topController.delegate = self
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
        bottomController.delegate = self
        addChild(bottomController, toContainer: bottomContainer)
    }

    private func setupButtonsContainer() {
        buttonsContainer = UIView()
        view.insertSubview(buttonsContainer, aboveSubview: scrollView)
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        let bottomDistance: CGFloat = Layout.distanceFromBottom
        NSLayoutConstraint.activate([
            buttonsContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            buttonsContainer.heightAnchor.constraint(equalToConstant: Layout.buttonContainerHeight),
            buttonsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomDistance)
            ])

        buttonsController = ButtonsController()
        buttonsController.delegate = self
        addChild(buttonsController, toContainer: buttonsContainer)
    }
}

extension ViewController: PanControllerDelegate {
    func present(_ panel: Panel) {
        switch panel {
        case .bottom:
            bottomContainer.center = view.center
            scrollContainer.center.y = view.center.y - view.frame.height
            centerContainer.center.y = view.center.y - view.frame.height
        case .top:
            topContainer.center = view.center
            scrollContainer.center.y = view.center.y + view.frame.height
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

extension ViewController: ButtonsDelegate {
    func scroll(to panel: Panel) {
        shouldAnimate = scrollView.contentOffset.x == UIScreen.main.bounds.width || panel == .center

        switch panel {
        case .left: scrollView.setContentOffset(.zero, animated: true)
        case .right: scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width * 2, y: 0), animated: true)
        case .center: scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: true)
        default: break
        }
    }

    func backToCamera() {
        UIView.animate(withDuration: 0.2) { self.present(.center) }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        shouldAnimate = true
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if shouldAnimate {
            let endColor: UIColor = scrollView.contentOffset.x < view.bounds.width ? .red : .blue
            let offset = (scrollView.contentOffset.x / view.frame.width) - 1
            scrollContainer.backgroundColor = UIColor.transition(from: .clear, to: endColor, with: abs(offset))
            buttonsController.animateButtons(offset)
        } else {
            let offset = (scrollView.contentOffset.x / view.frame.width) / 2
            scrollContainer.backgroundColor = UIColor.transition(from: .red, to: .blue, with: abs(offset))
        }
    }
}
