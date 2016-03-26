//
//  LABColor.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

// MARK: - LABColor additional init

extension LABColor {
  init(rgbVector: Vector3D) {
    self.init(r: rgbVector.x, g: rgbVector.y, b: rgbVector.z)
  }
  
  init(labVector: Vector3D) {
    self.init(l: labVector.x, a: labVector.y, b: labVector.z)
  }
  
  init(color: Color) {
    self.init(r: color.red(), g: color.green(), b: color.blue())
  }
}

// MARK: - LABColor convertions

extension LABColor {
  func toVector() -> Vector3D {
    return Vector3D(x: l, y: a, z: b)
  }
}

// MARK: - LABColor

public struct LABColor {
  private(set) var l: Float
  private(set) var a: Float
  private(set) var b: Float
  private(set) var color: Color?
  
  init(l: Float, a: Float, b: Float) {
    self.l = l
    self.a = a
    self.b = b
    
    color = self.calculateColor()
  }
  
  // http://www.easyrgb.com/index.php?X=MATH&H=01#text1
  // shouldSetColor == false for more optiomozation, but color will be nil
  
  init(r: Float, g: Float, b: Float, shouldSetColor: Bool = false) {
    var red = r
    var green = g
    var blue = b
    
    let normalizeRGBValue: (Float) -> (Float) = {
      value in
      if value > 0.04045 {
        return pow(((value + 0.055) / 1.055), 2.4)
      }
      return value / 12.92
    }
    
    red = normalizeRGBValue(red)
    green = normalizeRGBValue(green)
    blue = normalizeRGBValue(blue)
    
    red *= 100
    green *= 100
    blue *= 100
    
    var xValue = red * 0.4124 + green * 0.3576 + blue * 0.1805
    var yValue = red * 0.2126 + green * 0.7152 + blue * 0.0722
    var zValue = red * 0.0193 + green * 0.1192 + blue * 0.9505
    
    xValue /= 95.047
    yValue /= 100
    zValue /= 108.883
    
    let normalizeXYZ: (Float) -> (Float) = {
      value in
      if value > 0.008856 {
        return pow(value, 1.0 / 3.0)
      }
      return 7.787 * value + 16.0 / 116.0
    }
    
    xValue = normalizeXYZ(xValue)
    yValue = normalizeXYZ(yValue)
    zValue = normalizeXYZ(zValue)
    
    self.l = 116 * yValue - 16
    self.a = 500 * (xValue - yValue)
    self.b = 200 * (yValue - zValue)
    
    if shouldSetColor {
      self.color = Color(red: r, green: g, blue: b)
    }
  }
  
  // http://www.easyrgb.com/index.php?X=MATH&H=01#text1
  
  private func calculateColor() -> Color {
    var yValue = (l + 16) / 116
    var xValue = (a / 500 + yValue)
    var zValue = (yValue - b / 200)
    
    let normalizeXYZ: (Float) -> (Float) = {
      value in
      if pow(value, 3) > 0.008856 {
        return pow(value, 3)
      }
      return (value - 16.0 / 116.0) / 7.787
    }
    
    xValue = normalizeXYZ(xValue)
    yValue = normalizeXYZ(yValue)
    zValue = normalizeXYZ(zValue)
    
    xValue = 95.047 * xValue / 100
    yValue = 100 * yValue / 100
    zValue = 108.883 * zValue / 100
    
    var red = xValue * 3.2406 + yValue * -1.5372 + zValue * -0.4986
    var green = xValue * -0.9689 + yValue * 1.8758 + zValue * 0.0415
    var blue = xValue * 0.0557 + yValue * -0.2040 + zValue * 1.0570
    
    let normalizeRGBValue: (Float) -> (Float) = {
      value in
      if value > 0.0031308 {
        return 1.055 * pow(value, 1.0 / 2.4) - 0.055
      }
      return 12.92 * value
    }
    
    red = normalizeRGBValue(red)
    green = normalizeRGBValue(green)
    blue = normalizeRGBValue(blue)
    
    return Color(red: red, green: green, blue: blue)
  }
}

