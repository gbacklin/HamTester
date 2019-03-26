//
//  Utility.swift
//  NetworkCommunication
//
//  Created by Gene Backlin on 4/5/18.
//  Copyright © 2018 Gene Backlin. All rights reserved.
//

import UIKit

class Utility: NSObject {

    class func createError(domain: String, code: Int, text: String) -> Error {
        let userInfo: [String : String] = [NSLocalizedDescriptionKey: text]
        
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }

}
