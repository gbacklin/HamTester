//
//  ExamResultsDetailTableViewController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/30/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class ExamResultsDetailTableViewController: UITableViewController {
    @IBOutlet weak var titleTableViewCell: UITableViewCell!
    @IBOutlet weak var answer1TableViewCell: UITableViewCell!
    @IBOutlet weak var answer2TableViewCell: UITableViewCell!
    @IBOutlet weak var answer3TableViewCell: UITableViewCell!
    @IBOutlet weak var answer4TableViewCell: UITableViewCell!
    @IBOutlet weak var diagramTableViewCell: UITableViewCell!
    @IBOutlet weak var diagramImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var question: Question?
    var questionIndexPath: IndexPath?
    var examResults: [AnyObject]?
    var titleText: String?
    
    var previousBarButtonItem: UIBarButtonItem?
    var nextBarButtonItem: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 95.0
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.delegate = self
        
        previousBarButtonItem = UIBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(didTapPrevious(sender:)))
        nextBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapNext(sender:)))
        self.navigationItem.rightBarButtonItems = [nextBarButtonItem!, previousBarButtonItem!]

        checkNextPrevBarButtonItems()
        
        displayQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = titleText!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetImageView(_ sender: UITapGestureRecognizer) {
        self.scrollView.setZoomScale(0.0, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var count = 3
        
        if question!.figureTitle?.count == 0 {
            count = 2
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var size: CGFloat = 95.0
        
        switch indexPath.section {
        case 2:
            switch indexPath.row {
            case 0:
                size = 350.0
            default:
                size = 95.0
            }
        default:
            size = 95.0
        }
        return size
    }

    @objc func didTapPrevious(sender: UIBarButtonItem) {
        if questionIndexPath!.row != 0 {
            let questionIndex = questionIndexPath!.row - 1
            questionIndexPath!.row = questionIndex
            question = examResults![questionIndex] as? Question
            displayQuestion()
        }
        checkNextPrevBarButtonItems()
    }
    
    @objc func didTapNext(sender: UIBarButtonItem) {
        if questionIndexPath!.row < examResults!.count - 1 {
            let questionIndex = questionIndexPath!.row + 1
            questionIndexPath!.row = questionIndex
            question = examResults![questionIndex] as? Question
            displayQuestion()
        }
        checkNextPrevBarButtonItems()
    }

    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return diagramImageView
    }

    func displayQuestion() {
        titleTableViewCell.textLabel!.text = "Question \(questionIndexPath!.row+1) - \(String(describing: question!.name!))"
        titleTableViewCell.detailTextLabel!.text = question!.text
        
        let answers: [[String : AnyObject]] = question!.answers! as! [[String : AnyObject]]
        
        let one: Bool = (answers[0]["correct"] as? Bool)!
        let two: Bool = (answers[1]["correct"] as? Bool)!
        let three: Bool = (answers[2]["correct"] as? Bool)!
        let four: Bool = (answers[3]["correct"] as? Bool)!

        answer1TableViewCell.textLabel!.text = answers[0]["text"] as? String
        answer1TableViewCell.accessoryType = (one == true) ? .checkmark : .none
        answer2TableViewCell.textLabel!.text = answers[1]["text"] as? String
        answer2TableViewCell.accessoryType = (two == true) ? .checkmark : .none
        answer3TableViewCell.textLabel!.text = answers[2]["text"] as? String
        answer3TableViewCell.accessoryType = (three == true) ? .checkmark : .none
        answer4TableViewCell.textLabel!.text = answers[3]["text"] as? String
        answer4TableViewCell.accessoryType = (four == true) ? .checkmark : .none

//        if question!.selectedAnswerRow != question!.correctAnswerRow {
//            if let indexPath = question!.selectedAnswer {
//                let cell = tableView(tableView, cellForRowAt: indexPath)
//                cell.accessoryView = UIImageView(image: UIImage(named: "X.png"))
//            }
//        }
        
        if question!.figureTitle!.count > 0 {
            diagramImageView.image = UIImage(named: question!.figureFile!)
        }
        tableView.reloadData()
        
    }

    func checkNextPrevBarButtonItems() {
        switch questionIndexPath!.row {
        case 0:
            previousBarButtonItem!.isEnabled = false
        case examResults!.count - 1:
            nextBarButtonItem!.isEnabled = false
        default:
            previousBarButtonItem!.isEnabled = true
            nextBarButtonItem!.isEnabled = true
        }
    }

}
