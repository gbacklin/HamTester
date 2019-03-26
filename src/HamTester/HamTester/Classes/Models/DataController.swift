//
//  DataController.swift
//  HamTester
//
//  Created by Gene Backlin on 7/20/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class DataController: NSObject {
    var exam: Exam?
    var keys: [String]?
    var licenseClass: String?
    var questionPool: [String : AnyObject]?
    
    override init() {
        super.init()
    }
    
    convenience init(withClass licenseClass: String, keys: [String], pool: [String : AnyObject]) {
        self.init(exam: licenseClass, keys: keys, pool: pool)
    }

    convenience init(exam licenseClass: String, keys: [String], pool: [String : AnyObject]) {
        self.init()
        if exam != nil {
            exam = nil
        }
        
        let tempExam = Exam(licenseClass: licenseClass, keys: keys, pool: pool)
        self.keys = keys
        self.licenseClass = licenseClass
        self.exam = tempExam
    }
}
