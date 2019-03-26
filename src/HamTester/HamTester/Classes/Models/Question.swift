//
//  Question.swift
//  HamTester
//
//  Created by Gene Backlin on 7/20/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class Question: NSObject {
    var name: String?
    var text: String?
    var answers: [AnyObject]?

    var groupName: String?
    var groupDescription: String?
    var selectedAnswer: IndexPath?
    var selectedAnswerRow: Int?
    var correctAnswerRow: Int?

    var figureTitle: String?
    var figureFile: String?
    
    /*
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.text = aDecoder.decodeObject(forKey: "text") as? String
        self.answers = aDecoder.decodeObject(forKey: "answers") as? [AnyObject]

        self.groupName = aDecoder.decodeObject(forKey: "groupName") as? String
        self.groupDescription = aDecoder.decodeObject(forKey: "groupDescription") as? String
        self.selectedAnswer = aDecoder.decodeObject(forKey: "selectedAnswer") as? IndexPath
        self.selectedAnswerRow = aDecoder.decodeObject(forKey: "selectedAnswerRow") as? Int
        self.correctAnswerRow = aDecoder.decodeObject(forKey: "correctAnswerRow") as? Int

        self.figureTitle = aDecoder.decodeObject(forKey: "figureTitle") as? String
        self.figureFile = aDecoder.decodeObject(forKey: "figureFile") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.answers, forKey: "answers")

        aCoder.encode(self.groupName, forKey: "groupName")
        aCoder.encode(self.groupDescription, forKey: "groupDescription")
        aCoder.encode(self.selectedAnswer, forKey: "selectedAnswer")
        aCoder.encode(self.selectedAnswerRow, forKey: "selectedAnswerRow")
        aCoder.encode(self.correctAnswerRow, forKey: "correctAnswerRow")

        aCoder.encode(self.figureTitle, forKey: "figureTitle")
        aCoder.encode(self.figureFile, forKey: "figureFile")
    }
 */
}
