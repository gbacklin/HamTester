//
//  BeginExamViewController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/29/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class BeginExamViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet var drawerView: UIView!
    @IBOutlet weak var expireDateLabel: UILabel!
    
    var questionPool: [String : AnyObject]?
    var backgroundImage: UIImage?
    var iconImage: UIImage?
    var drawerHidden = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeDrawerView(drawer: drawerView, withView: view)
        
        backgroundImage = (self.tabBarController as? HamTesterTabBarController)!.backgroundImage
        iconImage = (self.tabBarController as? HamTesterTabBarController)!.iconImage
        if backgroundImage != nil {
            backgroundImageView.image = backgroundImage
            iconImageView.image = iconImage
        }
        if iconImage != nil {
            iconImageView.image = iconImage
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        questionPool = (self.tabBarController as? HamTesterTabBarController)!.questionPool
        if let expireDate: Date = questionPool!["Expires"] as? Date {
            checkForExpiredPool(expireDate: expireDate)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "BeginExam" {
            let controller: ExamNavigationViewController = segue.destination as! ExamNavigationViewController
            controller.hamTesterTabBarController = self.tabBarController
        }
    }

    func initializeDrawerView(drawer: UIView, withView: UIView) {
        let viewFrame: CGRect = withView.frame
        drawerHidden = true
        
        drawer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        drawer.frame = CGRect(x: viewFrame.size.width, y: 0.0, width: viewFrame.size.width-50.0, height: viewFrame.size.height)
        withView.addSubview(drawer)
    }
    
    func showDrawer(sender: Any) {
        if drawerHidden {
            drawerView.frame = CGRect(x: 0.0, y: -20.0, width: view.frame.size.width, height: 110.0)
            drawerView.isHidden = false

            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationDelay(0.2)
            UIView.setAnimationCurve(.easeIn)
            
            let viewFrame: CGRect = view.frame
            drawerView.frame = CGRect(x: 0.0, y: 80.0, width: viewFrame.size.width, height: 110.0)
            UIView.commitAnimations()
            
            drawerHidden = false
        }
    }
    
    func checkForExpiredPool(expireDate: Date) {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let now = Date()
        
        if now.compare(expireDate) == .orderedDescending {
            expireDateLabel.text = "Pool expired on: \(formatter.string(from: expireDate))"
            showDrawer(sender: expireDate)
        }
    }
}
