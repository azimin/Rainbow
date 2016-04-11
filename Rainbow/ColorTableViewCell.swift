//
//  ColorCollectionViewCell.swift
//  Rainbow
//
//  Created by Alex Zimin on 07/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
  
  @IBOutlet weak var colorView: UIView!
  @IBOutlet weak var colorNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layer.masksToBounds = true
    
    colorView.layer.borderWidth = 1
    colorView.layer.borderColor = Color.lightGreyColor().CGColorValue
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    colorView.layer.cornerRadius = colorView.frame.width / 2
  }
  
  var color: Color = Color.whiteColor() {
    didSet {
      let shouldUseBorder = color.shouldUseBorder(Color.whiteColor())
      colorView.layer.borderWidth = shouldUseBorder ? 1 : 0
      
      colorView.backgroundColor = color.UIColorValue
      colorNameLabel.text = ColorNamesCollection.getColorName(color)
    }
  }
}
