//
//  Service.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-08-15.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Service: NSObject {
    static let shared = Service()
    func fetchChatHistory(gameId: String, completion: @escaping ([String: Any]?, Error?) -> ()) {
        let url = "http://ec2-18-191-123-240.us-east-2.compute.amazonaws.com:8080/api/game/\(gameId)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {response in
            guard response.result.error == nil else {
                //Error encountered
                completion(nil, response.error)
                return
            }
            
            guard let json = response.result.value as? [String: Any] else { return }
            completion(json, nil)
        }
        

    }
}
