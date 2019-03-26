//
//  QuestionDetailTableViewController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/20/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class QuestionDetailTableViewController: UITableViewController {
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
    var exam: [AnyObject]?
    
    var previousBarButtonItem: UIBarButtonItem?
    var nextBarButtonItem: UIBarButtonItem?

    var previousSelectedQuestion: Question?

    var delegate: ExamTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        previousBarButtonItem = UIBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(didTapPrevious(sender:)))
        nextBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapNext(sender:)))

        self.navigationItem.rightBarButtonItems = [nextBarButtonItem!, previousBarButtonItem!]
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.delegate = self
        
        checkNextPrevBarButtonItems()
        
        displayQuestion()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateExam(exam: exam!)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetImageView(_ sender: UITapGestureRecognizer) {
        self.scrollView.setZoomScale(0.0, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        var count = 3
        
        if question!.figureTitle?.count == 0 {
            count = 2
        }
        
        return count
    }
    
    @objc func didTapPrevious(sender: UIBarButtonItem) {
        if questionIndexPath!.row != 0 {
            previousSelectedQuestion = nil
            let questionIndex = questionIndexPath!.row - 1
            questionIndexPath!.row = questionIndex
            question = exam![questionIndex] as? Question
            displayQuestion()
        }
        checkNextPrevBarButtonItems()
    }
    
    @objc func didTapNext(sender: UIBarButtonItem) {
        if questionIndexPath!.row < exam!.count - 1 {
            previousSelectedQuestion = nil
            let questionIndex = questionIndexPath!.row + 1
            questionIndexPath!.row = questionIndex
            question = exam![questionIndex] as? Question
            displayQuestion()
        }
        checkNextPrevBarButtonItems()
    }

    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return diagramImageView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            question!.selectedAnswer = indexPath
            question!.selectedAnswerRow = indexPath.row
            updateQuestion(question: question!)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == question!.selectedAnswer {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var size: CGFloat = 90.0

        switch indexPath.section {
        case 2:
            switch indexPath.row {
            case 0:
                size = 350.0
            default:
                size = 90.0
            }
        default:
            size = 90.0
        }
        return size
    }
    
    func displayQuestion() {
        titleTableViewCell.textLabel!.text = "Question \(questionIndexPath!.row+1) - \(String(describing: question!.name!))"
        titleTableViewCell.detailTextLabel!.text = question!.text
        
        answer1TableViewCell.textLabel!.text = (question!.answers![0] as? [String : AnyObject])!["text"] as? String
        answer1TableViewCell.accessoryType = .none
        answer2TableViewCell.textLabel!.text = (question!.answers![1] as? [String : AnyObject])!["text"] as? String
        answer2TableViewCell.accessoryType = .none
        answer3TableViewCell.textLabel!.text = (question!.answers![2] as? [String : AnyObject])!["text"] as? String
        answer3TableViewCell.accessoryType = .none
        answer4TableViewCell.textLabel!.text = (question!.answers![3] as? [String : AnyObject])!["text"] as? String
        answer4TableViewCell.accessoryType = .none

        if let indexPath = question!.selectedAnswer {
            let cell = tableView(tableView, cellForRowAt: indexPath)
            cell.accessoryType = .checkmark
        }
        
        if question!.figureTitle!.count > 0 {
            diagramImageView.image = UIImage(named: question!.figureFile!)
        }
        tableView.reloadData()

    }
    
    func updateQuestion(question: Question) {
        if previousSelectedQuestion != nil {
            let selectedCell: UITableViewCell = tableView(tableView, cellForRowAt: previousSelectedQuestion!.selectedAnswer!)
            selectedCell.accessoryType = .none
        }
        let newSelectedCell: UITableViewCell = tableView(tableView, cellForRowAt: question.selectedAnswer!)
        newSelectedCell.accessoryType = .checkmark
        previousSelectedQuestion = question
        
        tableView.reloadData()
    }

    func checkNextPrevBarButtonItems() {
        switch questionIndexPath!.row {
        case 0:
            previousBarButtonItem!.isEnabled = false
        case exam!.count - 1:
            nextBarButtonItem!.isEnabled = false
        default:
            previousBarButtonItem!.isEnabled = true
            nextBarButtonItem!.isEnabled = true
        }
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

