//
//  CatalogPresenter.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class CatalogPresenter: NSObject {
  
  //MARK: - Private properties
  private var catalogService: CatalogService?
  private weak var catalogView: CatalogView?
  
  private var products: [Product] = []
  
  //MARK: - Init
  init(catalogService: CatalogService) {
    self.catalogService = catalogService
  }
  
  //MARK: - Configuration
  func set(catalogView: CatalogView) {
    self.catalogView = catalogView
  }
  
  //MARK: - Presenter methods
  func register(for collectionView: UICollectionView) {
    collectionView.dataSource = self
    collectionView.register(CatalogCollectionViewCell.nib, forCellWithReuseIdentifier: CatalogCollectionViewCell.name)
  }
  
  func fetchProducts(with searchString: String = "Набор", and page: Int = 1) {
    catalogService?.fetchProducts(with: searchString, and: page, completion: { [weak self] (products, error) in
      if let error = error {
        self?.catalogView?.displayError(with: error, and: "")
      }
      
      if let products = products {
        if page == 1 { self?.products = [] }
        self?.products += products
        DispatchQueue.main.async {
          self?.catalogView?.displayProducts()
        }
      }
    })
  }
}

//MARK: - UICollectionViewDataSource
extension CatalogPresenter: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return products.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.name, for: indexPath) as! CatalogCollectionViewCell
    let product = products[indexPath.row]
    cell.set(product: product)
    return cell
  }
  
}
