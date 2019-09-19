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
  private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
  private var catalogService: CatalogService = CatalogServiceImplementation()
  private lazy var presenter = CatalogPresenter(catalogService: catalogService)
  
  private let layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    let padding: CGFloat = 2.0
    let width = UIScreen.main.bounds.width / 3 - (padding * 2)
    layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    layout.itemSize = CGSize(width: width, height: width)
    layout.minimumLineSpacing = padding
    layout.minimumInteritemSpacing = padding
    return layout
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    configureCollectionView()
    presenter.set(catalogView: self)
    presenter.fetchProducts()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    searchBarView = SearchBarView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
    view.addSubview(searchBarView!)
    
    collectionView.frame = CGRect(x: 0, y: searchBarView!.frame.height, width: view.bounds.width, height: view.bounds.height - searchBarView!.frame.height)
    collectionView.backgroundColor = .white
    view.addSubview(collectionView)
  }
  
  private func configureCollectionView() {
    presenter.register(for: collectionView)
  }
  
}

extension CatalogViewController: CatalogView {
  
  func displayProducts() {
    collectionView.reloadData()
  }
}
