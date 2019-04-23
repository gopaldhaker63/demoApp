//
//  ShowImageVC.swift
//  Assignment
//
//  Created by GOPAL on 23/04/19.
//  Copyright © 2019 tosc188. All rights reserved.
//

import UIKit

class ShowImageVC: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var imgPhoto: UIImageView!
    var category_thumb_image: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrolView.delegate = self
        scrolView.minimumZoomScale = 1.0
        scrolView.maximumZoomScale = 10.0
        
        self.title = "SHOW IMAGE"
        
        setImage()
    }
    // MARK:- Private Method
    func setImage(){
        if let strURL = category_thumb_image{
            if let url = URL(string: strURL){
                imgPhoto.kf.indicatorType = .activity
                imgPhoto.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholderImage"),
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            }
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgPhoto
    }
}
