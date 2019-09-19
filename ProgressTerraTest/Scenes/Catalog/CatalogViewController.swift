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
  private var collectionView: UICollectionView!
  private var catalogService: CatalogService = CatalogServiceImplementation()
  private lazy var presenter = CatalogPresenter(catalogService: catalogService)
  private var currentPage = 1
  
  private let layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    let padding: CGFloat = 2.0
    let width = UIScreen.main.bounds.width / 2 - (padding * 2)
    layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    layout.itemSize = CGSize(width: width, height: width + width / 2)
    layout.minimumLineSpacing = padding
    layout.minimumInteritemSpacing = padding
    layout.sectionInsetReference = .fromSafeArea
    return layout
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter.set(catalogView: self)
    presenter.fetchProducts()
    
    searchBarView = SearchBarView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
    searchBarView?.delegate = self
    view.addSubview(searchBarView!)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print(searchBarView!.frame.height)
    collectionView = UICollectionView(frame: CGRect(x: 0, y: searchBarView!.frame.height + searchBarView!.frame.height / 2, width: view.bounds.width, height: view.bounds.height - searchBarView!.frame.height), collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    view.addSubview(collectionView)
    configureCollectionView()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
  }
  
  private func configureCollectionView() {
    presenter.register(for: collectionView)
    collectionView.delegate = self
  }
  
  
  
}

extension CatalogViewController: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < -50 {
      searchBarView?.focusToSearchTextField()
    } else if scrollView.contentOffset.y > 0 {
      self.view.endEditing(true)
    }
  }
}

extension CatalogViewController: CatalogView {
  func displayError(with title: String, and message: String) {
    showAlert(title: title, message: message, completion: {})
  }
  
  
  func displayProducts() {
    collectionView.reloadData()
    currentPage += 1
  }
}

extension CatalogViewController: SearchBarViewDelegate {
  func fetchProducts(with searchText: String) {
    presenter.fetchProducts(with: searchText)
    view.endEditing(true)
  }
  
}
