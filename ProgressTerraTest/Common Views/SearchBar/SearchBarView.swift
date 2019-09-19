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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    searchBarTextField.frame = CGRect(x: textFieldPadding, y: textFieldPadding, width: bounds.width - textFieldPadding * 2, height: 40)
//    searchBarTextField.placeholder = "Поиск..."
    
    addSubview(searchBarTextField)
  }

}
