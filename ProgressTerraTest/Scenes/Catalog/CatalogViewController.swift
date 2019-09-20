//
//  CatalogViewController.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
  
  //MARK: - Private properties
  private var searchBarView: SearchBarView?
  private var collectionView: UICollectionView!
  private var catalogService: CatalogService = CatalogServiceImplementation()
  private lazy var presenter = CatalogPresenter(catalogService: catalogService)
  
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
  
  private var activity: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .gray)
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter.set(catalogView: self)
    presenter.fetchProducts()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    searchBarView = SearchBarView(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: 0))
    searchBarView?.delegate = self
    view.addSubview(searchBarView!)
    
    collectionView = UICollectionView(frame: CGRect(x: 0, y: searchBarView!.frame.height + searchBarView!.frame.height / 2, width: view.bounds.width, height: view.bounds.height - searchBarView!.frame.height), collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.isHidden = true
    view.addSubview(collectionView)
    configureCollectionView()
    
    activity.center = view.center
    view.addSubview(activity)
    activity.startAnimating()
  }
  
  //MARK: - Decorations
  private func configureCollectionView() {
    presenter.register(for: collectionView)
    collectionView.delegate = self
  }
  
}

//MARK: - UICollectionViewDelegate
extension CatalogViewController: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < -50 {
      searchBarView?.focusToSearchTextField()
    } else if scrollView.contentOffset.y > 0 {
      self.view.endEditing(true)
    }
  }
}

//MARK: - View methods
extension CatalogViewController: CatalogView {
  
  func displayError(with title: String, and message: String) {
    showAlert(title: title, message: message, completion: {})
    activity.stopAnimating()
  }
  
  func displayProducts() {
    activity.stopAnimating()
    collectionView.isHidden = false
    collectionView.reloadData()
  }
}

//MARK: - SearchBarViewDelegate
extension CatalogViewController: SearchBarViewDelegate {
  func fetchProducts(with searchText: String?) {
    activity.startAnimating()
    collectionView.isHidden = true
    guard let searchString = searchText else { presenter.fetchProducts(); return }
    presenter.fetchProducts(with: searchString)
    view.endEditing(true)
  }
  
}
