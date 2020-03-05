//
//  StaticAPI.swift
//  SwiftyHUD
//
//  Created by Bassem Abbas on 2/17/20.
//  Copyright © 2020 SwiftyHUD. All rights reserved.
//
import UIKit
import Foundation

// Class Extention
public extension SwiftyHUD {
    class func show() {
        SwiftyHUD.shared.show()
    }

    class func show(on view: UIView) {
        SwiftyHUD.shared.show(on: view)
    }

    class func show(on viewController: UIViewController, blockNavigation: Bool = true ) {
         SwiftyHUD.shared.show(on: viewController, blockNavigation: blockNavigation)
    }

    class func hide() {
        SwiftyHUD.shared.hide()
    }

    class func hide(duration: TimeInterval) {
        SwiftyHUD.shared.hide(duration: duration)
    }
}
