//
//  MyLibrary.swift
//  Assignment
//

//  Created by GOPAL on 23/04/19.
//  Copyright © 2019 tosc188. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public let passwordLenght = 6

class MyLibrary: NSObject {
    
    static let shared = MyLibrary()//singleton object
    static let deviceId = UIDevice().identifierForVendor?.uuidString//deviceID

    var appName:String{
        return "Assignment"
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
   
    func getAnimatingCircleViewWithLogo(frame:CGRect = UIScreen.main.bounds) -> UIView {
        let mainView: UIView = UIView(frame: frame)
        mainView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        
        let circle: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 90.0, height: 90.0))
        circle.center = mainView.center
        circle.backgroundColor = UIColor.clear
        mainView.addSubview(circle)
        
        circle.layer.cornerRadius = circle.frame.size.width/2.0
        circle.layer.borderWidth = 3.0
        circle.layer.borderColor = UIColor(patternImage: #imageLiteral(resourceName: "Img-Gradient-Circle")).cgColor
        
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2.0 * .pi
        rotation.duration = 0.7
        rotation.repeatCount = HUGE
        circle.layer.add(rotation, forKey: "Spin")
        
        let imgLogo: UIImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
        imgLogo.image = #imageLiteral(resourceName: "Img-AppIcon")
        imgLogo.center = mainView.center
        imgLogo.contentMode = .scaleToFill
        imgLogo.clipsToBounds = true
        mainView.addSubview(imgLogo)
        
        return mainView
    }
}
