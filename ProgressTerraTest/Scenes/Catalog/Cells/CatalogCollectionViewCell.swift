//
//  CatalogCollectionViewCell.swift
//  ProgressTerraTest
//
//  Created by Kazim Gajiev on 19/09/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit
import SDWebImage

class CatalogCollectionViewCell: UICollectionViewCell, NibLoadable {

  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var oldPriceLabel: UILabel!
  @IBOutlet weak var newPriceLabel: UILabel!
  
  func set(product: Product) {
    guard let imageUrl = URL(string: product.ulrMainImage) else { return }
    productImage.sd_setImage(with: imageUrl)
    productName.text = product.name
    
    let oldPrice = Int(product.priceBegin)
    let currentPrice = Int(product.priceCurrent)
    oldPriceLabel.isHidden = oldPrice == 0
    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(oldPrice) ₽")
    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
    oldPriceLabel.attributedText = attributeString
    newPriceLabel.text = "\(currentPrice)"
  }

}
