//
//  SearchBarTextField.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class SearchBarTextField: UITextField, UITextFieldDelegate {

  private let borderView = UIView()
  private var leftPadding: CGFloat = 5
  private let cornerRadius: CGFloat = 10
  private var isAnimating = false
  
  var scaleUpClosure: (() -> Void)?
  var scaleDownClosure: ((String) -> Void)?
  
  init(with leftIcon: UIImage) {
    super.init(frame: CGRect.zero)
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    imageView.contentMode = .scaleAspectFit
    imageView.image = leftIcon
    imageView.tintColor = Constants.searchColor
    leftView = imageView
    leftViewMode = .always
    
    textColor = Constants.searchColor
    
    borderView.layer.borderColor = Constants.searchColor.cgColor
    borderView.layer.borderWidth = 2
    borderView.layer.cornerRadius = cornerRadius
    borderView.backgroundColor = .clear
    addSubview(borderView)
    
    returnKeyType = .search
    
    delegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func scaleUpTextField() {
    isAnimating = true
    leftPadding = 10
    textColor = Constants.searchColor
    attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [NSAttributedString.Key.foregroundColor: Constants.searchColor])
    UIView.animate(withDuration: 0.5) {
      self.bounds.size.height += 10
      self.borderView.frame = self.bounds
      self.layoutIfNeeded()
      self.scaleUpClosure?()
    }
  }
  
  private func scaleDownTextField() {
    isAnimating = true
    leftPadding = 5
    textColor = .black
    attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: Constants.searchColor])
    guard let searchText = text else { return }
    UIView.animate(withDuration: 0.5) {
      self.bounds.size.height -= 10
      self.borderView.frame = CGRect(x: 0, y: 0, width: self.bounds.height, height: self.bounds.height)
      self.layoutIfNeeded()
      self.scaleDownClosure?(searchText)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if !isAnimating {
      borderView.frame = CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)
    }
  }
  
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.leftViewRect(forBounds: bounds)
    textRect.origin.x += leftPadding
    return textRect
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    let insets = UIEdgeInsets(top: 0, left: leftView!.bounds.width + (leftPadding >= 10 ? leftPadding * 2 : leftPadding * 4), bottom: 0, right: (leftView!.bounds.width + leftPadding >= 10 ? leftPadding * 2 : leftPadding * 4))
    return bounds.inset(by: insets)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    let insets = UIEdgeInsets(top: 0, left: leftView!.bounds.width + (leftPadding >= 10 ? leftPadding * 2 : leftPadding * 4), bottom: 0, right: (leftView!.bounds.width + leftPadding >= 10 ? leftPadding * 2 : leftPadding * 4))
    return bounds.inset(by: insets)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let insets = UIEdgeInsets(top: 0, left: leftView!.bounds.width + (leftPadding >= 10 ? leftPadding * 2 : leftPadding * 4), bottom: 0, right: (leftView!.bounds.width + leftPadding >= 10 ? leftPadding * 2 : leftPadding * 4))
    return bounds.inset(by: insets)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    layoutIfNeeded()
    scaleUpTextField()
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    layoutIfNeeded()
    scaleDownTextField()
  }
  
}
