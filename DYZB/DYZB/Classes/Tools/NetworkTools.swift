//
//  NetworkTools.swift
//  DYZB
//
//  Created by saber on 2020/10/31.
//

import Foundation
import Alamofire
enum MethodType {
    case options
    case get
    case head
    case post
    case put
    case patch
    case delete
    case trace
    case connect
}
class NetworkTools {
    static func requestData(_ type: MethodType, URLString: String, parameters: [String: Any]? = nil, finishedCallBack: @escaping (_ result: Any) -> ()) {
        if type == .get {
            Alamofire.request(URLString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                guard let result = response.result.value else{
                    print(response.result.error ?? "")
                    return
                }
                finishedCallBack(result)
            }
        }else if type == .post{
            Alamofire.request(URLString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                guard let result = response.result.value else{
                    print(response.result.error ?? "")
                    return }
                finishedCallBack(result)
            }
        }
    }
}

//struct NetworkTools {
//
//}r
