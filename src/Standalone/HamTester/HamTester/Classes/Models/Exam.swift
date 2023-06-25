//
//  Exam.swift
//  HamTester
//
//  Created by Gene Backlin on 7/20/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class Exam: NSObject {
    var title: String?
    var versionDate: Date?
    var fromDate: Date?
    var expireDate: Date?
    var subElements: [String : AnyObject]?
    
    var generatedExam: [AnyObject]?
    var subElementArray: [String]?
    var subElementKeyArray: [AnyObject]?
    var questionPool: [String : AnyObject]?
    
    override init() {
        super.init()
    }
    
    convenience init(licenseClass: String, keys: [String], pool: [String : AnyObject]) {
        self.init()
        
        questionPool = pool
        subElementArray = keys
        title = licenseClass
        versionDate = pool["Version"] as? Date
        fromDate = pool["From"] as? Date
        expireDate = pool["Expires"] as? Date
        subElements = pool["Subelements"] as? [String : AnyObject]
        subElementKeyArray = generateSubElementArray()
    }
    
    /*
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.versionDate = aDecoder.decodeObject(forKey: "versionDate") as? Date
        self.fromDate = aDecoder.decodeObject(forKey: "fromDate") as? Date
        self.expireDate = aDecoder.decodeObject(forKey: "expireDate") as? Date
        self.subElements = aDecoder.decodeObject(forKey: "subElements") as? [String : AnyObject]

        self.generatedExam = aDecoder.decodeObject(forKey: "generatedExam") as? [AnyObject]
        self.subElementArray = aDecoder.decodeObject(forKey: "subElementArray") as? [String]
        self.subElementKeyArray = aDecoder.decodeObject(forKey: "subElementKeyArray") as? [AnyObject]
        self.questionPool = aDecoder.decodeObject(forKey: "questionPool") as? [String : AnyObject]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.versionDate, forKey: "versionDate")
        aCoder.encode(self.fromDate, forKey: "fromDate")
        aCoder.encode(self.expireDate, forKey: "expireDate")
        aCoder.encode(self.subElements, forKey: "subElements")
        
        aCoder.encode(self.generatedExam, forKey: "generatedExam")
        aCoder.encode(self.subElementArray, forKey: "subElementArray")
        aCoder.encode(self.subElementKeyArray, forKey: "subElementKeyArray")
        aCoder.encode(self.questionPool, forKey: "questionPool")
    }
 */
    func generateSubElementArray() -> [AnyObject] {
        let keys = subElementArray
        var array: [AnyObject] = [AnyObject]()
        
        for key in keys! {
            let element = subElements![key]
            array.append(element!)
        }
        
        return array
    }
    
    func create() {
        var newGeneratedExam: [AnyObject]?
        var newExam: [AnyObject] = [AnyObject]()
        let keys = Array(subElements!.keys)
        
        for key in keys {
            let subElement: [String : AnyObject] = subElements![key] as! [String : AnyObject]
            let groups: [AnyObject] = subElement["groups"] as! [AnyObject]
            
            for group in groups {
                newExam.append(chooseQuestionsForSubElementGroup(group as! [String : AnyObject]))
            }
        }
        
        newGeneratedExam = newExam.shuffled()
        generatedExam = newGeneratedExam?.shuffled()
    }
    
    class func grade(examResults: [AnyObject]) -> ([AnyObject], Int) {
        var results: [AnyObject] = [AnyObject]()
        var errorCount = 0
        
        for question: Question in examResults as! [Question] {
            if question.selectedAnswerRow != question.correctAnswerRow {
                if question.selectedAnswerRow! < 5 {
                    var answers: [[String : AnyObject]] = question.answers! as! [[String : AnyObject]]
                    
                    var answer: [String : AnyObject] = answers[question.selectedAnswerRow!]
                    let text = "\(answer["text"]!) [X]"
                    answer["text"] = text as AnyObject
                    
                    answers[question.selectedAnswerRow!] = answer
                    question.answers! = answers as [AnyObject]
                }
                
                let name = "\(String(describing: question.name!)) - Incorrect"
                question.name = name
                errorCount += 1
            }
            results.append(question)
        }
        
        return (results, errorCount)
    }
    
    func rowForCorrectAnswer(answers: [AnyObject]) -> Int {
        var correctRow = 5
        
        for index in 0...answers.count-1 {
            let answer: [String : AnyObject] = answers[index] as! [String : AnyObject]
            let isCorrectAnswer: Bool = answer["correct"] as! Bool
            if isCorrectAnswer == true {
                correctRow = index
                break
            }
        }
        
        return correctRow
    }
    
    func chooseQuestionsForSubElementGroup(_ group: [String : AnyObject]) -> Question {
        let questionsForGroupElement: [AnyObject] = (group["questions"] as! [AnyObject]).shuffled()
        let randomIndex: Int = Int(arc4random_uniform(UInt32(questionsForGroupElement.count-1)))
        let randomQuestionFromGroup: [String : AnyObject] = questionsForGroupElement[randomIndex] as! [String : AnyObject]
        let answers = (randomQuestionFromGroup["answers"] as? [AnyObject])!.shuffled()
        
        let question = Question()
        question.name = randomQuestionFromGroup["name"] as? String
        question.text = randomQuestionFromGroup["question"] as? String
        question.answers = answers
        question.selectedAnswer = nil
        question.selectedAnswerRow = 5
        question.correctAnswerRow = rowForCorrectAnswer(answers: answers)
        
        question.groupName = group["name"] as? String
        question.groupDescription = group["description"] as? String
        
        question.figureTitle = randomQuestionFromGroup["figureTitle"] as? String
        question.figureFile = randomQuestionFromGroup["figureFile"] as? String
        
        return question
    }
}
