//
//  CatalogViewController.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
    view.addGestureRecognizer(tap)
  }
  
  @objc func tapped(_ tap: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
}
