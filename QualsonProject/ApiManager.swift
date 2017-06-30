//
//  ApiManager.swift
//  QualsonProject
//
//  Created by admin on 28/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Alamofire
import SwiftyJSON

private let naverApiHost = "https://openapi.naver.com/v1/search/image"

struct ApiManager {
    let url: String
    let method: HTTPMethod
    let parameters: Parameters
    let headers: HTTPHeaders
    init?(path: String, method: HTTPMethod = .get, parameters: Parameters = [:], headers: HTTPHeaders = [:]) {
        url = naverApiHost + path
        self.method = method
        self.parameters = parameters
        self.headers = ["X-Naver-Client-Id": App.naverClientID, "X-Naver-Client-Secret": App.naverClientSecret]
    }
    func request(success: @escaping(_ data: Dictionary<String, Any>, _ statusCode: Int)-> Void, fail: @escaping (_ error: Error?)-> Void) {
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).responseJSON { response in
            if response.result.isSuccess {
                success(response.result.value as! Dictionary, (response.response?.statusCode)!)
            } else {
                fail(response.result.error)
            }
        }
    }
}
