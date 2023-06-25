//
//  ViewController.swift
//  HamTesterTechnician
//
//  Created by Gene Backlin on 7/16/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit
import HamTester

class ViewController: UIViewController {
    var questionPool: [String : AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadQuestionPool()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        perform(#selector(endWait(sender:)), with: nil, afterDelay: 1.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func endWait(sender: Any) {
        performSegue(withIdentifier: "BeginHamTester", sender: self)
    }

    func loadQuestionPool() {
        questionPool = PropertyList.readFromArchive(filename: "Pool")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BeginHamTester" {
            let controller: HamTesterTabBarController = segue.destination as! HamTesterTabBarController
            controller.questionPool = questionPool
            controller.licenseClass = questionPool!["Class"] as? String
            controller.subelementKeys = Array((questionPool!["Subelements"] as? [String : AnyObject])!.keys).sorted()
            controller.backgroundImage = UIImage(named: "Screenshot_01")
            controller.iconImage = UIImage(named: "ArtWork")
        }
    }
    
}

