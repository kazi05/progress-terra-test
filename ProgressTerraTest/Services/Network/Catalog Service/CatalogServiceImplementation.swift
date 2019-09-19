//
//  CatalogServiceImplementation.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation


class CatalogServiceImplementation: BasicService, CatalogService {
  
  func fetchProducts(with searchString: String, and page: Int, completion: @escaping ([Product]?, String?) -> Void) {
    let param = ["SearchString": searchString]
    request(path: APIPath.fetchProducts, with: param, and: page) { (json, error) in
      if let error = error {
        completion(nil, error)
      }
      
      if let json = json {
        var photos = [Product]()
        guard let data = json["data"].dictionary, let results = data["listProducts"]?.array else {
          completion(nil, nil)
          return
        }
        
        for item in results {
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try item.rawData()
            let photo = try jsonDecoder.decode(Product.self, from: data)
            photos.append(photo)
          } catch {
            print(error.localizedDescription)
            completion(nil, error.localizedDescription)
          }
        }
        
        completion(photos, nil)
      }
    }
  }
  
}
