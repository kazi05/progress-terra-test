//
//  CatalogView.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation

protocol CatalogView: class {
  func displayProducts()
  func displayError(with title: String, and message: String)
}
