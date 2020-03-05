//
//  StackedImage.swift
//  Example
//
//  Created by Bassem Abbas on 2/23/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class StackedImage: UIView {
    
    private var stackedCount: Int = 0 {
        didSet {
            rearrangeImages()
        }
    }
    var images: [UIImageView] = []
    
    @IBInspectable var imageCornerRadius: CGFloat = 0.0 {
        didSet {
            rearrangeImages()
        }
    }
    @IBInspectable var spacing: Int = 10 {
        didSet {
            stackView.spacing = CGFloat(-(spacing))
        }
    }
    
    @IBInspectable var placeHolder: UIImage?
    
    @IBInspectable var count: Int {
        get {
            return stackedCount
        }
        set {
            stackedCount = newValue
        }
    }
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageViewConfig: ((UIImageView) -> Void) = { image in
        image.layer.cornerRadius = image.bounds.height / 2
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.purple.cgColor
        
        //UIColor(displayP3Red: 20, green: 20, blue: 20, alpha: 1).cgColor
        image.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        image.layer.masksToBounds = true
        } {
        didSet {
            images.forEach({ imageViewConfig($0) })
        }
    }
    
    var imageForImageView: ((_ index: Int, _ imageView: UIImageView) -> Void)?
    
    //custom views should override this to return true if
    //they cannot layout correctly using autoresizing.
    //from apple docs https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        images.forEach({
            $0.layer.cornerRadius = self.bounds.height
        })
    }
    
    private func commonInit() {
        //custom initialization
        addSubview(stackView)
        clipsToBounds = true
    }
    
    override func updateConstraints() {
        //set subview constraints here
        NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
            ])
        
        super.updateConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //manually set subview frames here
        print(#function)
    }
    
    //    public func configerImages() {
    //         images.forEach({ imageViewConfig($0) })
    //    }
    public func updateImages() {
        if let clouser = imageForImageView {
            for (index, image) in images.enumerated() {
                clouser( index, image)
            }
        }
    }
    func rearrangeImages () {
        
        while images.count > stackedCount {
            let last = images.removeLast()
            last.removeFromSuperview()
        }
        
        while images.count < stackedCount {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            images.append(view)
            view.image = placeHolder
            imageViewConfig(view)
            view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            stackView.addArrangedSubview(view)
            if let clouser = imageForImageView,
                let index = stackView.subviews.firstIndex(of: view) {
                clouser( index, view)
            }
        }
    }
}
