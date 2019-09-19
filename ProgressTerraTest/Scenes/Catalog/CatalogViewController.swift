//
//  CatalogViewController.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
  
  var searchBarView: SearchBarView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
    view.addGestureRecognizer(tap)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    searchBarView = SearchBarView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
    searchBarView?.backgroundColor = UIColor.groupTableViewBackground
    view.addSubview(searchBarView!)
  }
  
  @objc func tapped(_ tap: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
}
