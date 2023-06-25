//
//  PoolGroupQuestionDetailTableViewController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/29/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class PoolGroupQuestionDetailTableViewController: UITableViewController {
    @IBOutlet weak var titleTableViewCell: UITableViewCell!
    @IBOutlet weak var answer1TableViewCell: UITableViewCell!
    @IBOutlet weak var answer2TableViewCell: UITableViewCell!
    @IBOutlet weak var answer3TableViewCell: UITableViewCell!
    @IBOutlet weak var answer4TableViewCell: UITableViewCell!
    @IBOutlet weak var diagramTableViewCell: UITableViewCell!
    @IBOutlet weak var diagramImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    var previousBarButtonItem: UIBarButtonItem?
    var nextBarButtonItem: UIBarButtonItem?
    var question: [String : AnyObject]?

    var questions: [[String : AnyObject]]?
    var questionIndexPath: IndexPath?
    var titleText: String?

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
        
        question = questions![questionIndexPath!.row]
        title = titleText!
        
        checkNextPrevBarButtonItems()
        
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func didTapPrevious(sender: UIBarButtonItem) {
        if questionIndexPath!.row != 0 {
            let questionIndex = questionIndexPath!.row - 1
            questionIndexPath!.row = questionIndex
            question = questions![questionIndex]
            displayQuestion()
        }
        checkNextPrevBarButtonItems()
    }
    
    @objc func didTapNext(sender: UIBarButtonItem) {
        if questionIndexPath!.row < questions!.count - 1 {
            let questionIndex = questionIndexPath!.row + 1
            questionIndexPath!.row = questionIndex
            question = questions![questionIndex]
            displayQuestion()
        }
        checkNextPrevBarButtonItems()
    }

    @IBAction func resetImageView(_ sender: UITapGestureRecognizer) {
        self.scrollView.setZoomScale(0.0, animated: true)
    }
    
    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return diagramImageView
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        var count = 3
        
        if (question!["figureFile"] as! String).count == 0 {
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

    func displayQuestion() {
        titleTableViewCell.textLabel!.text = "Question \(String(describing: question!["name"]!))"
        titleTableViewCell.detailTextLabel!.text = question!["question"] as? String
        
        let answers: [[String : AnyObject]] = question!["answers"] as! [[String : AnyObject]]
        
        answer1TableViewCell.textLabel!.text = (answers[0])["text"] as? String
        answer1TableViewCell.accessoryType = ((answers[0])["correct"] as? Bool)! ? .checkmark : .none
        answer2TableViewCell.textLabel!.text = (answers[1])["text"] as? String
        answer2TableViewCell.accessoryType = ((answers[1])["correct"] as? Bool)! ? .checkmark : .none
        answer3TableViewCell.textLabel!.text = (answers[2])["text"] as? String
        answer3TableViewCell.accessoryType = ((answers[2])["correct"] as? Bool)! ? .checkmark : .none
        answer4TableViewCell.textLabel!.text = (answers[3])["text"] as? String
        answer4TableViewCell.accessoryType = ((answers[3])["correct"] as? Bool)! ? .checkmark : .none

        if (question!["figureTitle"] as? String)!.count > 0 {
            diagramImageView.image = UIImage(named: question!["figureFile"] as! String)
        }
        tableView.reloadData()

    }

    func checkNextPrevBarButtonItems() {
        switch questionIndexPath!.row {
        case 0:
            previousBarButtonItem!.isEnabled = false
        case questions!.count - 1:
            nextBarButtonItem!.isEnabled = false
        default:
            previousBarButtonItem!.isEnabled = true
            nextBarButtonItem!.isEnabled = true
        }
        
    }

}
