//
//  SwiftyHUD.swift
//  SwiftyHUD
//
//  Created by Bassem Abbas on 2/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import UIKit

//TODO: create BackgroundColors enum

enum BackgroundStyle {
    case solidColor(color: UIColor)  // TODO: replaced with BackgroundColors
    case blur(style: UIBlurEffect.Style, backgroundColor: UIColor)
}

protocol SHViewDelegate: class {
    
}

enum HUDStyle {
    case native(style: UIActivityIndicatorView.Style, color: UIColor)
    case lottie(path: String)
    case custom(view: UIView & SHViewDelegate)
}

struct SwiftyHUDConfig {
    static var `default`:SwiftyHUDConfig = SwiftyHUDConfig()

    var showDuration: TimeInterval = 0.3
    var hideDuration: TimeInterval = 0.3
    var allowUserInteraction: Bool = false

    var width: CGFloat = 88
    var height: CGFloat = 88
    var cornerRadious: CGFloat = 8
    var backgroundStyle: BackgroundStyle = .solidColor(color: UIColor.black.withAlphaComponent(0.6))
    //.blur(
//        style: .light,
//        backgroundColor: UIColor.red)
    //.solidColor(color: UIColor.black.withAlphaComponent(0.6))
    
    var allowMotionEffect: Bool = true
    var motionEffectValue: CGFloat = 4
    var hudStyle: HUDStyle = .native(style: .white, color: .black)
}

class SHBackgroundView: UIView {

}

class SHBezelView: UIView {

}

open class SwiftyHUD {

    var config: SwiftyHUDConfig = .default
    private var view : UIView?
    public static let shared: SwiftyHUD = SwiftyHUD()

    /// show hud on a separated window
    func show() {
        UIView.animate(
        withDuration: config.showDuration) {
            //TODO:
            
        }
    }
    /// show hud on a given view
    func show(on view: UIView) {
        let swiftyHud = createHUD(with: view.frame.size)
        view.addSubview(swiftyHud)
        swiftyHud.alpha = 0
        self.view = swiftyHud
        UIView.animate(
            withDuration: config.showDuration,
            animations: {
                swiftyHud.alpha = 1
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
                self.view?.alpha = 0
            }, completion: { _ in
            //TODO:
                self.view?.removeFromSuperview()
                self.view = nil
            })
    }
    
    fileprivate func configerBezelView(_ bezel: SHBezelView, config: SwiftyHUDConfig) {
        bezel.superview?.alignedCenter(to: bezel)
        bezel.constrait(width: config.width, height: config.height)
        bezel.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        
        bezel.layer.cornerRadius = config.cornerRadious
        bezel.layer.masksToBounds = true
        bezel.isUserInteractionEnabled = !config.allowUserInteraction
        if config.allowMotionEffect, config.motionEffectValue > 0 {
            let value = abs(config.motionEffectValue)
            let min = -value
            let max = value
                  
            let xMotion = UIInterpolatingMotionEffect(
                keyPath: "layer.transform.translation.x",
                type: .tiltAlongHorizontalAxis)
            xMotion.minimumRelativeValue = min
            xMotion.maximumRelativeValue = max
                  
            let yMotion = UIInterpolatingMotionEffect(
                keyPath: "layer.transform.translation.y",
                type: .tiltAlongVerticalAxis)
            yMotion.minimumRelativeValue = min
            yMotion.maximumRelativeValue = max
                  
            let motionEffectGroup = UIMotionEffectGroup()
            motionEffectGroup.motionEffects = [xMotion, yMotion]

            bezel.addMotionEffect(motionEffectGroup)
        }
        
        switch config.hudStyle {
        case .native(style: let style, color: let color):
            let activity = UIActivityIndicatorView(style: style)
            activity.color = color
            activity.startAnimating()
            bezel.addSubview(activity)
            activity.translatesAutoresizingMaskIntoConstraints = false
            bezel.alignedCenter(to: activity)
        default:
            break
        }
    }
    
    fileprivate func configerBackgroundView(_ background: SHBackgroundView) {
        switch config.backgroundStyle {
        case .solidColor(color: let color):
             background.backgroundColor = color
        case .blur(style: let style, backgroundColor: let backgroundColor):
             background.backgroundColor = backgroundColor
            
            let blurEffect = UIBlurEffect(style: style)
            let blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView.frame = background.bounds
            background.addSubview(blurredEffectView)
//        default:
//            background.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }
    }
    
    private func createHUD( with size: CGSize) -> UIView {
        
        let container = UIView(frame: CGRect(origin: .zero, size: size))
        container.translatesAutoresizingMaskIntoConstraints = false
        let background = SHBackgroundView(frame: CGRect(origin: .zero, size: size))
        container.addSubview(background)
        background.pin(to: container)
        configerBackgroundView(background)
        let bezel = SHBezelView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: config.width,
                    height: config.height)))
        background.addSubview(bezel)

        configerBezelView(bezel, config: config)
        
        [container, background, bezel]
            .forEach({ $0.isUserInteractionEnabled = !config.allowUserInteraction })
        return container
    }
}

extension UIView {
    
    func pin(to view: UIView, constant: CGFloat = 0.0 ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let top = self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        let bottom = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (-constant))
        let leading = self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        let trailing = self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (-constant))
        
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
    
    func alignedCenter(to view: UIView, constant: CGFloat = 0.0 ) {
        let centerYAnchor = self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        let centerXAnchor = self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: (-constant))
       
        NSLayoutConstraint.activate([centerYAnchor, centerXAnchor])
    }
    
    func constrait(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let widthAnchor = self.widthAnchor.constraint(equalToConstant: width)
        let heightAnchor = self.heightAnchor.constraint(equalToConstant: height)
        NSLayoutConstraint.activate([widthAnchor, heightAnchor])
    }
}
