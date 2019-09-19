//
//  CatalogPresenter.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class CatalogPresenter: NSObject {
  
  private var catalogService: CatalogService?
  private weak var catalogView: CatalogView?
  
  private var products: [Product] = []
  
  init(catalogService: CatalogService) {
    self.catalogService = catalogService
  }
  
  func set(catalogView: CatalogView) {
    self.catalogView = catalogView
  }
  
  func register(for collectionView: UICollectionView) {
    collectionView.dataSource = self
    collectionView.register(CatalogCollectionViewCell.nib, forCellWithReuseIdentifier: CatalogCollectionViewCell.name)
  }
  
  func fetchProducts(with searchString: String = "Набор", and page: Int = 1) {
    catalogService?.fetchProducts(with: searchString, and: page, completion: { [weak self] (products, error) in
      print(products)
      self?.catalogView?.displayProducts()
    })
  }
}

extension CatalogPresenter: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return products.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.name, for: indexPath) as! CatalogCollectionViewCell
    
    return cell
  }
  
}
