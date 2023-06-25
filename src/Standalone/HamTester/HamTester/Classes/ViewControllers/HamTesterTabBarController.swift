//
//  HamTesterTabBarController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/17/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

open class HamTesterTabBarController: UITabBarController {
    open var questionPool: [String : AnyObject]?
    open var licenseClass: String?
    open var subelementKeys: [String]?
    open var backgroundImage: UIImage?
    open var iconImage: UIImage?

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
