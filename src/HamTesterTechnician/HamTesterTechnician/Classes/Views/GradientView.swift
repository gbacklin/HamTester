//
//  GradientView.swift
//  HamTesterTechnician
//
//  Created by Gene Backlin on 7/30/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var topColor: UIColor = UIColor.white
    @IBInspectable var bottomColor: UIColor = UIColor.black
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
    }
}
