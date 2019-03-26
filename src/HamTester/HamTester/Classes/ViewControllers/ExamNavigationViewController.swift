//
//  ExamNavigationViewController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/29/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class ExamNavigationViewController: UINavigationController {
    var hamTesterTabBarController: UITabBarController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let controller: ExamTableViewController = self.viewControllers[0] as! ExamTableViewController
        controller.hamTesterTabBarController = hamTesterTabBarController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
