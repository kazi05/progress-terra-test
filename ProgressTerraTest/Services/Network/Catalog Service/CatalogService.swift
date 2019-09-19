//
//  CatalogService.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation

protocol CatalogService {
  func fetchProducts(with searchString: String, and page: Int, completion: @escaping ([Product]?, String?) -> Void)
}
