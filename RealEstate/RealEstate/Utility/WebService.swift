//
//  WebService.swift
//  RealEstate
//
//  Created by ashish on 6/4/19.
//  Copyright © 2019 Technical. All rights reserved.
//

import Foundation
import Alamofire

typealias DictionaryCompletionHandler = (_ response: NSDictionary, _ error: Error?) -> Void

class WebService
{
    class func GetDataFromServer(completionHandler completion:@escaping DictionaryCompletionHandler) {
        
        Alamofire.request(APPDATALISTAPI, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
                
            case .success(let JSON):
                
                let response = JSON as! NSDictionary
                //print("response -> \(response)")
                completion(response, nil)
                
            case .failure(let error):
                completion(NSDictionary.init(), error)
            }
        }
    }
    
}

