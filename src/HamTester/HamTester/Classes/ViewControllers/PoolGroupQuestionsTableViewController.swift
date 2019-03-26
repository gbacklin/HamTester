//
//  PoolGroupQuestionsTableViewController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/29/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class PoolGroupQuestionsTableViewController: UITableViewController {
    var group: [String : AnyObject]?
    var questions: [[String : AnyObject]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90.0

        questions = group!["questions"] as? [[String : AnyObject]]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "\(group!["name"] as! String)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions!.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let question: [String : AnyObject] = questions![indexPath.row]
        
        // Configure the cell...
        cell.textLabel!.text = "Question \(String(describing: question["name"]!))"
        cell.detailTextLabel!.text = "\(String(describing: question["question"]!))"

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowPoolGroupQuestionDetail" {
            let controller: PoolGroupQuestionDetailTableViewController = segue.destination as! PoolGroupQuestionDetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller.questions = questions
            controller.titleText = "\(group!["name"] as! String)"
            controller.questionIndexPath = indexPath
        }

    }

}
