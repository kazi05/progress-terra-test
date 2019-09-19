//
//  BasicService.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BasicService {
  
  fileprivate struct APIConstants {
    static let host = "http://iswiftdata.1c-work.net/api"
    
    static let headers: HTTPHeaders = [
      "AccessKey": "test_05fc5ed1-0199-4259-92a0-2cd58214b29c",
      "pageSizeIncome": "12"
    ]
  }
  
  
  func request(path: APIPath, with params: Parameters, and headers: [String: String], completion: @escaping (_ json: JSON?, _ error: String?) -> Void) {
    let fullUrlString = String(format: "%@/%@/", APIConstants.host, path.rawValue)
    var staticHeaders = APIConstants.headers
    headers.forEach { staticHeaders[$0.key] = $0.value }
    
    if !Reachabelity.isConnectedToNetwork(){
      completion(nil, "No internet connection")
    } else {
      Alamofire
        .request(fullUrlString, method: path.method, parameters: params, encoding: URLEncoding.default, headers: staticHeaders)
        .responseJSON { (response) in
          switch response.result {
          case .failure(let error): completion(nil, error.localizedDescription)
          case .success(let value):
            let json = JSON(value)
            completion(json, nil)
          }
      }
    }
  }
}

enum APIPath: String {
  case fetchProducts = "products/searchproductsbycategory"
  
  var method: HTTPMethod {
    switch self {
    case .fetchProducts: return .get
    default: return .post
    }
  }
}
