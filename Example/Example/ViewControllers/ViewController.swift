//
//  ViewController.swift
//  Example
//
//  Created by Bassem Abbas on 2/17/20.
//  Copyright © 2020 Bassem Abbas. All rights reserved.
//

import UIKit
import SwiftyHUD

class ViewController: UIViewController {

    @IBOutlet private weak var stackedImage: StackedImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        stackedImage.imageViewConfig = { imageView in
//            imageView.layer.cornerRadius = self.stackedImage.bounds.height / 2
//            imageView.layer.borderColor = UIColor.brown.cgColor
//            imageView.layer.borderWidth = 2
//            imageView.layer.masksToBounds = true
//            imageView.backgroundColor = .green
//        }
//        stackedImage.imageForImageView = { index, imageView in
//            imageView.sd_asdas()
//        }
        
//        stackedImage.updateImages()
    }
    
    @IBAction func showOnSelfTapped(_ sender: UIButton) {
        SwiftyHUD.show(on: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            SwiftyHUD.hide()
        }
        //ackedImage.count += 1
    }
}
