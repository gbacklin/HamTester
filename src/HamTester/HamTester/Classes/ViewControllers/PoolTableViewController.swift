//
//  PoolTableViewController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/16/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class PoolTableViewController: UITableViewController {
    var questionPool: [String : AnyObject]?
    var licenseClass: String?
    var subelementKeys: [String]?
    var groups: [[String : AnyObject]]?

    var questionCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90.0
        
        questionPool = (self.tabBarController as? HamTesterTabBarController)!.questionPool
        licenseClass = (self.tabBarController as? HamTesterTabBarController)!.licenseClass
        subelementKeys = (self.tabBarController as? HamTesterTabBarController)!.subelementKeys
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.topItem!.title = questionPool!["Class"] as? String
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController!.navigationBar.topItem!.title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return subelementKeys!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if let subelement: [String : AnyObject] = subElementForKey(key: subelementKeys![section]) {
            groups = subelement["groups"] as? [[String : AnyObject]]
            count = groups!.count
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var cellText: String = ""
        var cellDetailText: String = ""

        if let subelement: [String : AnyObject] = subElementForKey(key: subelementKeys![indexPath.section]) {
            groups = subelement["groups"] as? [[String : AnyObject]]
            let group: [String : AnyObject] = groups![indexPath.row]
            cellText = "Group \(group["name"] as! String)"
            cellDetailText = group["description"] as! String
        }

        // Configure the cell...
        cell.textLabel!.text = cellText
        cell.detailTextLabel!.text = cellDetailText
        
        return cell
    }
    
    func subElementForKey(key: String) -> [String : AnyObject]? {
        let subelements: [String : AnyObject]  = questionPool!["Subelements"] as! [String : AnyObject]
        return subelements[key] as? [String : AnyObject]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SUBELEMENT \(subelementKeys![section])"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowSubelementGroupQuestions" {
            let controller: PoolGroupQuestionsTableViewController = segue.destination as! PoolGroupQuestionsTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            if let subelement: [String : AnyObject] = subElementForKey(key: subelementKeys![indexPath!.section]) {
                groups = subelement["groups"] as? [[String : AnyObject]]
                controller.group = groups![indexPath!.row]
            }
        }
        
    }
    
}
