//
//  APIParser.swift
//  Assignment
//
//  Created by GOPAL on 23/04/19.
//  Copyright © 2019 tosc188. All rights reserved.
//

import UIKit

class APICallParser: NSObject {
    
    func callAPI(ur:String, completion:@escaping APIParserProtocol.APICompletionHandler){
        
        let strURL = ur
        var request = URLRequest(url: URL(string:strURL)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let strResponse = data != nil ? (String(data: data!, encoding: .utf8) ?? "") : ""
            print(strResponse)
            if (error == nil){
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        if(data != nil){
                            self.parseData(data: data!, completion: completion)
                        }else{
                            DispatchQueue.main.async {
                                completion(APIParser([],true, "Failed to get response"))

                            }
                        }
                    }else{
                        DispatchQueue.main.async {
                            completion(APIParser([],true, "Failed to get response"))
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                    completion(APIParser([],true, "Failed to get response"))
                }
            }
        }
        dataTask.resume()
    }
    func parseData(data: Data, completion: @escaping APIParserProtocol.APICompletionHandler) {
        do {
            let baseData = try JSONDecoder().decode(BaseData.self, from: data)
            DispatchQueue.main.async {
                completion(APIParser(baseData,true, "Failed to get response"))
            }
        } catch  {
            DispatchQueue.main.async {
                completion(APIParser([],true, "Failed to get response"))
            }
        }
    }

}
