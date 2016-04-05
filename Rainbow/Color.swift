//
//  ColorBase.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

enum RGB: String {
  case Red
  case Blue
  case Green
}

struct ColorCollection {
  var baseColor: UIColor
  var rule: (() -> ())?
}

public class Color {
  var RGBVector: OptimizeVector3DType
  var alpha: Float = 1.0
  
  init() {
    RGBVector = Optimize3DFloatVector(x: 1.0, y: 1.0, z: 1.0)
  }
  
  init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) {
    RGBVector = Optimize3DCGFloatVector(x: red, y: green, z: blue)
    self.alpha = alpha.toFloat()
  }
  
  init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
    RGBVector = Optimize3DDoubleVector(x: red, y: green, z: blue)
    self.alpha = alpha.toFloat()
  }
  
  init(red: Float, green: Float, blue: Float, alpha: Float = 1.0) {
    RGBVector = Optimize3DFloatVector(x: red, y: green, z: blue)
    self.alpha = alpha
  }
  
  convenience init!(color: UIColor) {
    let cgColor = color.CGColor
    
    let numberOfComponents = CGColorGetNumberOfComponents(cgColor)
    let components = CGColorGetComponents(cgColor)
    
    let red, green, blue, alpha: CGFloat
    
    if numberOfComponents == 4 {
      red = components[0]
      green = components[1]
      blue = components[2]
      alpha = components[3]
    } else {
      red = components[0]
      green = components[0]
      blue = components[0]
      alpha = components[1]
    }
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
  
  convenience init?(color: UIColor?) {
    guard let color = color else {
      return nil
    }
    self.init(color: color)
  }
  
  convenience init(hexString: String) {
    var hex = hexString
    
    if hex.hasPrefix("#") {
      hex = hex.substringFromIndex(hex.startIndex.advancedBy(1))
    }
    
    if (hex.rangeOfString("(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .RegularExpressionSearch) != nil) {
      
      if hex.characters.count == 3 {
        let redHex   = hex.substringToIndex(hex.startIndex.advancedBy(1))
        
        let greenHex = hex.substringWithRange(Range<String.Index>(hex.startIndex.advancedBy(1)..<hex.startIndex.advancedBy(2)))
        let blueHex  = hex.substringFromIndex(hex.startIndex.advancedBy(2))
        
        hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
      }
      
      let redHex = hex.substringToIndex(hex.startIndex.advancedBy(2))
      let greenHex = hex.substringWithRange(Range<String.Index>(hex.startIndex.advancedBy(2)..<hex.startIndex.advancedBy(4)))
      let blueHex = hex.substringWithRange(Range<String.Index>(hex.startIndex.advancedBy(4)..<hex.startIndex.advancedBy(6)))
      
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
  
  // Tupples
  private var _floatRGBVector: (red: Float, green: Float, blue: Float)?
  internal var floatRGBVector: (red: Float, green: Float, blue: Float) {
    var value = _floatRGBVector
    if value == nil {
      value = RGBVector.toFloatTuple()
      _floatRGBVector = value
    }
    return value!
  }
  
  private var _cgfloatRGBVector: (red: CGFloat, green: CGFloat, blue: CGFloat)?
  internal var cgfloatRGBVector: (red: CGFloat, green: CGFloat, blue: CGFloat) {
    var value = _cgfloatRGBVector
    if value == nil {
      value = RGBVector.toCGFloatTuple()
      _cgfloatRGBVector = value
    }
    return value!
  }
  
  private var _doubleRGBVector: (red: Double, green: Double, blue: Double)?
  internal var doubleRGBVector: (red: Double, green: Double, blue: Double) {
    var value = _doubleRGBVector
    if value == nil {
      value = RGBVector.toDoubleTuple()
      _doubleRGBVector = value
    }
    return value!
  }
  
  var UIColorValue: UIColor {
    return UIColor(red: red(), green: green(), blue: blue(), alpha: alpha.toCGFloat())
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