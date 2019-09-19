//
//  CatalogViewController.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
  
  private var searchBarView: SearchBarView?
  private var collectionView = UICollectionView()
  private var presenter = CatalogPresenter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionView()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    searchBarView = SearchBarView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
    view.addSubview(searchBarView!)
    
    collectionView.frame = CGRect(x: 0, y: searchBarView!.frame.height, width: view.bounds.width, height: view.bounds.height - searchBarView!.frame.height)
    view.addSubview(collectionView)
  }
  
  private func configureCollectionView() {
    presenter.register(for: collectionView)
  }
  
}
