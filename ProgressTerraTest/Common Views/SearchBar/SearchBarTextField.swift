//
//  SearchBarTextField.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class SearchBarTextField: UITextField {

  private let borderLayer = CALayer()
  private let leftPadding: CGFloat = 10
  private let cornerRadius: CGFloat = 10
  
  init(with leftIcon: UIImage) {
    super.init(frame: CGRect.zero)
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    imageView.contentMode = .scaleAspectFit
    imageView.image = leftIcon
    imageView.tintColor = Constants.searchColor
    leftView = imageView
    leftViewMode = .always
    
    textColor = Constants.searchColor
    attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [NSAttributedString.Key.foregroundColor: Constants.searchColor])
    
    borderLayer.borderColor = Constants.searchColor.cgColor
    borderLayer.borderWidth = 2
    borderLayer.cornerRadius = cornerRadius
    layer.addSublayer(borderLayer)
    
    returnKeyType = .search
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    borderLayer.frame = layer.bounds
  }
  
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.leftViewRect(forBounds: bounds)
    textRect.origin.x += leftPadding
    return textRect
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: leftView!.bounds.width + leftPadding * 2, y: bounds.origin.y, width: bounds.width, height: bounds.height)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: leftView!.bounds.width + leftPadding * 2, y: bounds.origin.y, width: bounds.width, height: bounds.height)
  }
  
}
