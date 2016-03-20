//
//  ColorCompare.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

// https://en.wikipedia.org/wiki/Color_difference

import UIKit

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
    return CIE76SquaredColorDifference().colorDifference(firstLABColor, lab2: secondLABColor).toCGFloat()
  }
  
  var CIE94: CGFloat {
    return CIE94SquaredColorDifferenceFunction(lab1: firstLABColor, lab2: secondLABColor).toCGFloat()
  }
  
  func CIE94(kL: Float = 1, kC: Float = 1, kH: Float = 1, K1: Float = 0.045, K2: Float = 0.015) -> CGFloat {
    return CIE94SquaredColorDifferenceFunction(kL, kC: kC, kH: kH, K1: K1, K2: K2, lab1: firstLABColor, lab2: secondLABColor).toCGFloat()
  }
  
  var CIE2000: CGFloat {
    return CIE2000SquaredColorDifferenceFunction(lab1: firstLABColor, lab2: secondLABColor).toCGFloat()
  }
  
  func CIE2000(kL: Float = 1, kC: Float = 1, kH: Float = 1) -> CGFloat {
    return CIE2000SquaredColorDifferenceFunction(kL, kC: kC, kH: kH, lab1: firstLABColor, lab2: secondLABColor).toCGFloat()
  }
}