//
//  NetworkManager.swift
//  MVVMTest
//
//  Created by Ravi Rana on 09/03/21.
//

import UIKit
import Alamofire

class NetworkManager {
    typealias PostDataCompletion = ([PostData]?, Error?) -> ()
    
    private static let baseUrl = "https://jsonplaceholder.typicode.com"
    private static let path = "/posts"

    static func getPostSData(completion:@escaping(PostDataCompletion)) {
        let headers: HTTPHeaders = [.contentType("application/json")]
        
    AF.request(baseUrl+path,method: .get, headers: headers).responseDecodable(of: [PostData].self)  { (response) in
            
            switch response.result {
            case .success(let res):
                debugPrint(res)
                completion(res , nil)
            case .failure(let err):
                debugPrint(err)
                completion(nil, err)
            }
        }
    }
}
