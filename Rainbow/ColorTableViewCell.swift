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
    
    colorView.layer.borderWidth = 10
    colorView.layer.borderColor = Color.lightGreyColor().CGColorValue
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    colorView.layer.cornerRadius = colorView.frame.width / 2
  }
}
