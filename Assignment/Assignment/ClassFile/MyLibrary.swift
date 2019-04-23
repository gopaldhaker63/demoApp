//
//  MyLibrary.swift
//  Assignment
//

//  Created by GOPAL on 23/04/19.
//

import Foundation
import UIKit
import AVFoundation

class MyLibrary: NSObject {
    
    static let shared = MyLibrary()//singleton object

    var appName:String{
        return "Assignment"
    }
    enum Messages : String{
        case Internet_connection_error = "internet_connection_error"
    }
    
    /// This method is used to generating activity indicator view for given frame
    ///
    /// - Parameter frame: frame for activity Indicator
    /// - Returns: View containing activity Indicator
    func activityIndicatorView(frame:CGRect = UIScreen.main.bounds) -> UIView {
        let viewIndicator = UIView(frame: frame)
        viewIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let act = UIActivityIndicatorView(style: .white)
        act.startAnimating()
        act.center = viewIndicator.center
        viewIndicator.addSubview(act)
        return viewIndicator
    }
}
