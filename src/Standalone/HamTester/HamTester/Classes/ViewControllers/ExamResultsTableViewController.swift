//
//  ExamResultsTableViewController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/29/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class ExamResultsTableViewController: UITableViewController {
    var exam: [AnyObject]?
    var minCorrect: Int?
    var examResults: [AnyObject] = [AnyObject]()
    var errorCount = 0

    var doneBarButtonItem: UIBarButtonItem?
    var saveBarButtonItem: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:true);

        doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done(sender:)))
        saveBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save(sender:)))
        
        self.navigationItem.leftBarButtonItem = doneBarButtonItem!
        //self.navigationItem.rightBarButtonItem = saveBarButtonItem!

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 95.0
        
        (examResults, errorCount) = Exam.grade(examResults: exam!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let correctCount: CGFloat = (CGFloat(examResults.count-errorCount))
        let percentage: CGFloat = (correctCount/CGFloat(examResults.count) * 100.0)

        if correctCount < CGFloat(minCorrect!) {
            title = String(format: "Score %.0f%% (Failed)", percentage)
        } else {
            title = String(format: "Score %.0f%% (Passed)", percentage)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let question: Question = examResults[indexPath.row] as! Question
        
        // Configure the cell...
        cell.textLabel!.text = "Question \(indexPath.row+1) - \(String(describing: question.name!))"
        cell.detailTextLabel!.text = "\(String(describing: question.text!))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }

    @objc func done(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save(sender: UIBarButtonItem) {
        print("Save")
        dismiss(animated: true, completion: nil)
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "ShowResultsDetail" {
            let controller: ExamResultsDetailTableViewController = segue.destination as! ExamResultsDetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            
            controller.examResults = examResults
            controller.titleText = title
            controller.question = examResults[indexPath!.row] as? Question
            controller.questionIndexPath = indexPath
        }
     }
    
}
