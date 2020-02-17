//
//  SwiftyHUD.swift
//  SwiftyHUD
//
//  Created by Bassem Abbas on 2/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import UIKit

struct SwiftyHUDConfig {
    static var `default`:SwiftyHUDConfig = SwiftyHUDConfig()

    var showDuration: TimeInterval = 0.3
    var hideDuration: TimeInterval = 0.3
    var allowUserInteraction: Bool = false

    var width: CGFloat = 88
    var height: CGFloat = 88
    var cornerRadious: CGFloat = 8

}

class SHBackgroundView: UIView {

}

class SHBazilView: UIView {

}

class SwiftyHUD {

    var config: SwiftyHUDConfig = .default

    let shared: SwiftyHUD = SwiftyHUD()

    /// show hud on a separated window
    func show() {
        UIView.animate(
        withDuration: config.showDuration) {
            //TODO:
        }
    }
    /// show hud on a given view
    func show(on view: UIView) {
        UIView.animate(
            withDuration: config.showDuration,
            animations: {

            }, completion: { _ in
            //TODO:
            })
    }

    func show(on viewController: UIViewController, blockNavigation: Bool = false ) {

        let view: UIView

        if blockNavigation == false {
            view = viewController.view
        } else {
            if let nav = viewController.navigationController,
                let navView = nav.view {
                if let tap = nav.tabBarController,
                    let tapView = tap.view {
                    view = tapView
                } else {
                    view = navView
                }
            } else if let tap = viewController.tabBarController,
                let tapView = tap.view {
                if let nav = tap.navigationController,
                    let navView = nav.view {
                    view = navView
                } else {
                    view = tapView
                }
            } else {
                view = viewController.view
            }
        }
        show(on: view)
    }

    func hide(animated: Bool = true) {
        if animated {
            hide(duration: config.hideDuration)
        } else {
            hide(duration: TimeInterval(0.0))
        }

    }

    func hide(duration: TimeInterval) {
        UIView.animate(
            withDuration: duration,
            animations: {

            }, completion: { _ in
            //TODO:
            })
    }
}

// Class Extention
extension SwiftyHUD {
    class func show() {

    }

    class func show(on view: UIView) {

    }

    class func show(on viewController: UIViewController, blockNavigation: Bool = false ) {

    }

    class func hide() {

    }

    class func hide(duration: Int) {

    }
}
