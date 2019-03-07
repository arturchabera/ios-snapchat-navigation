//
//  PanController.swift
//  SnapchatNavigation
//
//  Created by Artur Chabera on 05/03/2019.
//  Copyright © 2019 Artur Chabera. All rights reserved.
//

import UIKit

protocol PanControllerDelegate: class {
    func present(_ panel: Panels)
    func view(_ panel: Panels) -> UIView
}

class PanController: UIViewController {

    private var horizontalDirection: Panels = .center
    private var originalCenter = CGPoint()
    private var topPanelCenter = CGPoint()
    private var bottomPanelCenter = CGPoint()

    weak var delegate: PanControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }

    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard
            let scrollContainer = delegate?.view(.center),
            let mapContainer = delegate?.view(.top),
            let leaderboardsContainer = delegate?.view(.bottom),
            let cameraContainer = delegate?.view(.camera)
            else { return }

        /// 1. If velocity is high enought, scroll to desired view directly
        let velocity = recognizer.velocity(in: view).y/1000
        switch velocity {
        case _ where velocity > 0.5: horizontalDirection = .top
        case _ where velocity < -0.5: horizontalDirection = .bottom
        default: break
        }

        let translation = recognizer.translation(in: view)
        /// 2. Log func to slow down dragging speed of scroll view
        let additionalTranslation = (1 - log10(max(1, abs(translation.y)))/10) * translation.y

        switch recognizer.state {
        case .began:
            /// 3. Setting center of dragged view
            originalCenter = scrollContainer.center
            topPanelCenter = mapContainer.center
            bottomPanelCenter = leaderboardsContainer.center
        case .changed:
            /// 4. View is dragging with pan gesture
            scrollContainer.center = CGPoint(x: originalCenter.x, y: originalCenter.y + additionalTranslation)
            cameraContainer.center = CGPoint(x: originalCenter.x, y: originalCenter.y + additionalTranslation)

            if mapContainer.center.y < view.center.y {
                mapContainer.center = CGPoint(x: topPanelCenter.x, y: topPanelCenter.y + translation.y/2)
            }
            leaderboardsContainer.center = CGPoint(x: bottomPanelCenter.x, y: bottomPanelCenter.y + translation.y)
        case .ended:
            /// 5. handle drag by pan or velocity changes
            switch scrollContainer.center {
            case _ where scrollContainer.center.y > view.center.y + view.frame.height/5:
                horizontalDirection = .top
            case _ where scrollContainer.center.y < view.center.y - view.frame.height/5:
                horizontalDirection = .bottom
            default:
                horizontalDirection = .center
            }
            handleEndedState()
        default: break
        }
    }

    private func handleEndedState() {
        UIView.animate(withDuration: 0.2) {
            switch self.horizontalDirection {
            case .bottom: self.delegate?.present(.bottom)
            case .top: self.delegate?.present(.top)
            case .center, .camera: self.delegate?.present(.center)
            default: break
            }
        }
    }
}

extension PanController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let recognizer = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        let translation = recognizer.translation(in: view)
        return abs(translation.x) < abs(translation.y)
    }
}
