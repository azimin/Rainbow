//
//  ColorBase.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

enum RGB {
  case Red
  case Blue
  case Green
}

struct ColorCollection {
  var baseColor: UIColor
  var rule: (() -> ())?
}

struct Color {
  var red: CGFloat
  var green: CGFloat
  var blue: CGFloat
  var alpha: CGFloat = 1.0
  
  init() {
    self.red = 1.0
    self.green = 1.0
    self.blue = 1.0
  }
  
  init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) {
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }
  
  init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
    self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
  }
  
  init(red: Float, green: Float, blue: Float, alpha: Float = 1.0) {
    self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
  }
  
  init(color: UIColor) {
    let cgColor = color.CGColor
    let components = CGColorGetComponents(cgColor)
  
    self.red = components[0]
    self.green = components[1]
    self.blue = components[2]
    self.alpha = CGColorGetAlpha(cgColor)
  }
  
  init?(color: UIColor?) {
    guard let color = color else {
      return nil
    }
    self.init(color: color)
  }
  
  init(hexString: String) {
    var hex = hexString
    
    if hex.hasPrefix("#") {
      hex = hex.substringFromIndex(hex.startIndex.advancedBy(1))
    }
    
    if (hex.rangeOfString("(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .RegularExpressionSearch) != nil) {
      
      if hex.characters.count == 3 {
        let redHex   = hex.substringToIndex(hex.startIndex.advancedBy(1))
        let greenHex = hex.substringWithRange(Range<String.Index>(start: hex.startIndex.advancedBy(1), end: hex.startIndex.advancedBy(2)))
        let blueHex  = hex.substringFromIndex(hex.startIndex.advancedBy(2))
        
        hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
      }
      
      let redHex = hex.substringToIndex(hex.startIndex.advancedBy(2))
      let greenHex = hex.substringWithRange(Range<String.Index>(start: hex.startIndex.advancedBy(2), end: hex.startIndex.advancedBy(4)))
      let blueHex = hex.substringWithRange(Range<String.Index>(start: hex.startIndex.advancedBy(4), end: hex.startIndex.advancedBy(6)))
      
      var redInt:   CUnsignedInt = 0
      var greenInt: CUnsignedInt = 0
      var blueInt:  CUnsignedInt = 0
      
      NSScanner(string: redHex).scanHexInt(&redInt)
      NSScanner(string: greenHex).scanHexInt(&greenInt)
      NSScanner(string: blueHex).scanHexInt(&blueInt)
      
      self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: 1.0)
    } else {
      self.init()
    }
  }

  var UIColorValue: UIColor {
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
 
  var RGBValue: RGB {
    var result: RGB = .Red
    var minimalValue = ColorCompare(firstColor: self, secondColor: Color.redColor()).CIE76
    
    let greenValue = ColorCompare(firstColor: self, secondColor: Color.greenColor()).CIE76
    if greenValue < minimalValue {
      minimalValue = greenValue
      result = .Green
    }
    
    let blueValue = ColorCompare(firstColor: self, secondColor: Color.blueColor()).CIE76
    if blueValue < minimalValue {
      minimalValue = greenValue
      result = .Blue
    }
    
    return result
  }
}