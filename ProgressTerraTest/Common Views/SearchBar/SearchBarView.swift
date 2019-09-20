//
//  SearchBarView.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

protocol SearchBarViewDelegate: class {
  func fetchProducts(with searchText: String?)
}

class SearchBarView: UIView {

  //MARK: - Private properties
  private let searchBarTextField: SearchBarTextField = SearchBarTextField(with: #imageLiteral(resourceName: "search.png"))
  private let textFieldPadding: CGFloat = 10
  
  private lazy var breadCrumbsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
    label.textColor = Constants.searchColor
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .left
    return label
  }()
  
  private lazy var clearButton: SearchBarClearButton = {
    let button = SearchBarClearButton(with: "Очистить")
    button.alpha = 0
    button.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
    return button
  }()
  
  //MARK:- Public properties
  weak var delegate: SearchBarViewDelegate?
  
  //MARK: - Configure
  func set(delegate: SearchBarViewDelegate) {
    self.delegate = delegate
  }
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    actions()
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    actions()
    
    setup()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    searchBarTextField.frame.origin = CGPoint(x: textFieldPadding, y: textFieldPadding)
    breadCrumbsLabel.frame.origin = CGPoint(x: textFieldPadding, y: searchBarTextField.frame.height + 10)
    clearButton.frame.origin = CGPoint(x: bounds.width - 150 - textFieldPadding, y: searchBarTextField.frame.height + 10)
    
    frame.size.height = textFieldPadding + searchBarTextField.frame.height + breadCrumbsLabel.frame.height + (textFieldPadding * 1.5)
    
    guard let currentIndex = superview?.subviews.firstIndex(of: self) else { return }
    if superview!.subviews.count > currentIndex + 1, let nextView = superview?.subviews[currentIndex + 1] {
      nextView.frame.origin.y = frame.origin.y + bounds.height
    }
  }
  
  //MARK: - Decoration
  private func setup() {
    searchBarTextField.frame = CGRect(x: textFieldPadding, y: textFieldPadding, width: bounds.width - textFieldPadding * 2, height: 30)
    addSubview(searchBarTextField)
    
    breadCrumbsLabel.text = "Lorema sdad asd"
    breadCrumbsLabel.sizeToFit()
    breadCrumbsLabel.frame.size.height = 30
    addSubview(breadCrumbsLabel)
    
    clearButton.frame = CGRect(x: bounds.width - 150 - textFieldPadding, y: searchBarTextField.frame.height + 10, width: 150, height: 30)
    addSubview(clearButton)
  }
  
  //MARK: - Textfield actions
  private func actions() {
    //Animate in
    searchBarTextField.scaleUpClosure = { [weak self] in
      UIView.animate(withDuration: 0.5, animations: {
        self?.breadCrumbsLabel.font = self?.breadCrumbsLabel.font.withSize(18)
        self?.clearButton.alpha = 1
        self?.layoutIfNeeded()
      })
    }
    
    //Animate out
    searchBarTextField.scaleDownClosure = { [weak self] (searchText, isReturn) in
      print(searchText)
      UIView.animate(withDuration: 0.5, animations: {
        self?.breadCrumbsLabel.font = self?.breadCrumbsLabel.font.withSize(12)
        self?.clearButton.alpha = 0
        self?.layoutIfNeeded()
      })
      if !searchText.isEmpty && isReturn {
        self?.delegate?.fetchProducts(with: searchText)
      }
    }
  }
  
  func focusToSearchTextField() {
    searchBarTextField.becomeFirstResponder()
  }
  
  //MARK: - Button actions
  @objc private func clearButtonTapped(_ sender: UIButton) {
    searchBarTextField.text = ""
    delegate?.fetchProducts(with: nil)
  }

}
