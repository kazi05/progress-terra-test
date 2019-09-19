//
//  SearchBarClearButton.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class SearchBarClearButton: UIButton {

  init(with title: String, and image: UIImage = #imageLiteral(resourceName: "error.png")) {
    super.init(frame: CGRect.zero)
    setTitle(title, for: .normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
    setTitleColor(Constants.searchColor, for: .normal)
    titleLabel?.textAlignment = .center
    
    setImage(image, for: .normal)
    tintColor = Constants.searchColor
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if imageView != nil {
      imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
      titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
    }
  }
  
}
