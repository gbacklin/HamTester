//
//  ExamTableViewController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/16/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

protocol ExamTableViewControllerDelegate {
    func updateExam(exam: [AnyObject])
}

class ExamTableViewController: UITableViewController {
    var questionPool: [String : AnyObject]?
    var licenseClass: String?
    var subelementKeys: [String]?
    var exam: [AnyObject]?
    
    var questionCount: Int?
    var hamTesterTabBarController: UITabBarController?

    var doneBarButtonItem: UIBarButtonItem?
    var gradeBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(done(sender:)))
        gradeBarButtonItem = UIBarButtonItem(title: "Grade", style: .plain, target: self, action: #selector(grade(sender:)))
        self.navigationItem.rightBarButtonItem = gradeBarButtonItem!
        self.navigationItem.leftBarButtonItem = doneBarButtonItem!

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 95.0

        questionPool = (hamTesterTabBarController as? HamTesterTabBarController)!.questionPool
        licenseClass = (hamTesterTabBarController as? HamTesterTabBarController)!.licenseClass
        subelementKeys = (hamTesterTabBarController as? HamTesterTabBarController)!.subelementKeys
        
        let dataController = DataController(withClass: licenseClass!, keys: subelementKeys!, pool: questionPool!)
        dataController.exam!.create()
        exam = dataController.exam!.generatedExam
        questionCount = exam!.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = questionPool!["Class"] as? String
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        title = "Return to Grade"
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
        return exam!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let question: Question = exam![indexPath.row] as! Question
        
        // Configure the cell...
        cell.textLabel!.text = "Question \(indexPath.row+1) - \(String(describing: question.name!))"
        cell.detailTextLabel!.text = "\(String(describing: question.text!))"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowQuestionDetail" {
            let controller: QuestionDetailTableViewController = segue.destination as! QuestionDetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller.question = exam![indexPath!.row] as? Question
            controller.questionIndexPath = indexPath
            controller.exam = exam
        } else if segue.identifier == "GradeExam" {
            let controller: ExamResultsTableViewController = segue.destination as! ExamResultsTableViewController
            controller.exam = exam
            controller.minCorrect = questionPool!["MinCorrect"] as? Int
        }
    }

    @objc func done(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func grade(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GradeExam", sender: self)
    }

}
