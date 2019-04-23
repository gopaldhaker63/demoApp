//
//  APIParserProtocol.swift
//  Assignment
//
//  Created by GOPAL on 23/04/19.
//  Copyright © 2019 tosc188. All rights reserved.
//

import UIKit
import Foundation

protocol APIParserProtocol {
    
    /// Completion Handler for passing result to back
    //typealias APICompletionHandler = ((_ data:Any?,_ success:Bool,_ message:String?,_ ivr:String?)->())
    typealias APICompletionHandler = ((_ object:APIParser)->())
    
    /// Call API using postData & completion Handler
    ///
    /// - Parameters:
    ///   - data: post data if any otherwise this parameter would be nil
    ///   - completion: completionHandler
    func callAPI(_ data:[String:Any]?,completion:@escaping APICompletionHandler)
    
    
    /// Private method to parse data received from Server
    ///
    /// - Parameters:
    ///   - data: data received from server
    ///   - completion: completionHandler
    func parseXMLData(data:Data,completion:@escaping APICompletionHandler)
}

struct APIParser {
    let data:Any?
    let success:Bool
    let message:String?
    
    init(_ data:Any?,_ success:Bool,_ message:String?) {
        self.data = data
        self.success = success
        self.message = message
    }
}
