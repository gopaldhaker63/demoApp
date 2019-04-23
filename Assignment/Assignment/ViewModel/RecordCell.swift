//
//  RecordCell.swift
//  Assignment
//
//  Created by GOPAL on 23/04/19.
//  Copyright © 2019 tosc188. All rights reserved.
//

import UIKit
import Kingfisher

class RecordCell: UITableViewCell {
    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var ivThumble: UIImageView!
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func populateCell(dataRecord:DataRecods){
        self.lblCategory.text = dataRecord.category_name
        if let strDate = dataRecord.created_at?.date,let timeZone = dataRecord.created_at?.timezone{
            self.lblDateTime.text = self.get_Date_time_from_UTC_time(date: strDate, timeZone: timeZone)
        }
        
        viewInner.layer.cornerRadius = 12.0
        viewInner.layer.shadowColor = UIColor.black.cgColor
        viewInner.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewInner.layer.shadowOpacity = 0.2
        viewInner.layer.shadowRadius = 6.0
        
        if let strURL = dataRecord.category_thumb_image{
            if let url = URL(string: strURL){
                ivThumble.kf.indicatorType = .activity
                //        let processor = DownsamplingImageProcessor(size: imageView.size)
                ivThumble.kf.setImage(
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
    func get_Date_time_from_UTC_time(date : String,timeZone:String) -> String {
        
        let dateformattor = DateFormatter()
        dateformattor.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        dateformattor.timeZone = NSTimeZone.local
        let dt = date
        let dt1 = dateformattor.date(from: dt as String)
        dateformattor.dateFormat = "MMM dd, yyyy, HH:mm a"
        dateformattor.timeZone = NSTimeZone.init(abbreviation: timeZone)! as TimeZone
        return dateformattor.string(from: dt1!)
    }

}
