//
//  ViewController.swift
//  Assignment
//
//  Created by tosc188 on 23/04/19.
//  Copyright © 2019 tosc188. All rights reserved.
//

import UIKit

class ShowListingVC: UIViewController {

    @IBOutlet weak var tblRecords: UITableView!

    var arrRecords = [DataRecods]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ShowListingVC.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LISTING"
        self.tblRecords.addSubview(self.refreshControl)
        callAPI()
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tblRecords.reloadData()
        refreshControl.endRefreshing()
    }

    // MARK-: Private Method
 
    func callAPI(){
        let apiCallParser = APICallParser()
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            apiCallParser.callAPI(ur: "http://api.vishalinfosoft.com/api/category") { (object) in
                if let baseData = object.data as? BaseData{
                    if let arrRecordD = baseData.dataRecods{
                        self.arrRecords = arrRecordD
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(baseData) {
                            let defaults = UserDefaults.standard
                            defaults.set(encoded, forKey: "data")
                        }
                        self.tblRecords.reloadData()
                        for data in arrRecordD{
                            print(data.category_name ?? "")
                        }
                    }
                }
            }
        }else{
            print("Internet Connection not Available!")
            if let data = UserDefaults.standard.object(forKey: "data") as? Data {
                let decoder = JSONDecoder()
                if let loadedData = try? decoder.decode(BaseData.self, from: data) {
                    if let baseData = loadedData as? BaseData{
                        if let arrRecordD = baseData.dataRecods{
                            self.arrRecords = arrRecordD
                            self.tblRecords.reloadData()
                        }
                    }
                    self.tblRecords.reloadData()
                }
            }
        }
    }
}

extension ShowListingVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordCell = self.tblRecords.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        recordCell.populateCell(dataRecord: arrRecords[indexPath.row])
        recordCell.selectionStyle = .none
        return recordCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageVC") as! ShowImageVC
        vc.category_thumb_image = arrRecords[indexPath.row].category_thumb_image
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
