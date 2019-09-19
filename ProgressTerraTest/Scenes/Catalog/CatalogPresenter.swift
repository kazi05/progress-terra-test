//
//  CatalogPresenter.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class CatalogPresenter: NSObject {
  
  private weak var catalogView: CatalogView?
  
  private var products: [Product] = []
  
  func set(catalogView: CatalogView) {
    self.catalogView = catalogView
  }
  
  func register(for collectionView: UICollectionView) {
    collectionView.dataSource = self
    collectionView.register(CatalogCollectionViewCell.nib, forCellWithReuseIdentifier: CatalogCollectionViewCell.name)
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
