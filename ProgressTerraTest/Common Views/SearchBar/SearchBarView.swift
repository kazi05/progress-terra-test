//
//  SearchBarView.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

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
    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    actions()
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
    
    frame.size.height = textFieldPadding + searchBarTextField.frame.height + breadCrumbsLabel.frame.height + (textFieldPadding * 2)
    frame.origin.y = (textFieldPadding + searchBarTextField.frame.height + breadCrumbsLabel.frame.height + (textFieldPadding * 2)) / 2
  }
  
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
  
  private func actions() {
    searchBarTextField.scaleUpClosure = { [weak self] in
      UIView.animate(withDuration: 0.5, animations: {
        self?.breadCrumbsLabel.font = self?.breadCrumbsLabel.font.withSize(18)
        self?.clearButton.alpha = 1
        self?.layoutIfNeeded()
      })
    }
    
    searchBarTextField.scaleDownClosure = { [weak self] (searchText) in
      print(searchText)
      UIView.animate(withDuration: 0.5, animations: {
        self?.breadCrumbsLabel.font = self?.breadCrumbsLabel.font.withSize(14)
        self?.clearButton.alpha = 0
        self?.layoutIfNeeded()
      })
    }
  }
  
  @objc private func buttonTapped(_ sender: UIButton) {
    
  }

}
