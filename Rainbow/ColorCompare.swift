//
//  ColorCompare.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

// https://en.wikipedia.org/wiki/Color_difference

struct ColorCompare {
  var firstColor: Color {
    didSet {
      firstLABColor = LABColor(color: firstColor)
    }
  }
  
  var secondColor: Color {
    didSet {
      secondLABColor = LABColor(color: secondColor)
    }
  }
  
  private(set) var firstLABColor: LABColor
  private(set) var secondLABColor: LABColor
  
  init(firstColor: Color, secondColor: Color) {
    self.firstColor = firstColor
    self.secondColor = secondColor
    
    firstLABColor = LABColor(color: firstColor)
    secondLABColor = LABColor(color: secondColor)
  }
  
  var CIE76: CGFloat {
    return sqrt(pow((firstLABColor.l - secondLABColor.l), 2) +
      pow((firstLABColor.a - secondLABColor.a), 2) + 
      pow((firstLABColor.b - secondLABColor.b), 2))
  }
}