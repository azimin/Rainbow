//
//  ColorCircle.swift
//  Rainbow
//
//  Created by Alex Zimin on 05/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

protocol ColorWheelType {
  static func colorAtAngle(angle: Int) -> Color
  // Take default color saturation and brightness
  static func colorAtAngle(defaultColor: Color, angle: Int) -> Color
  static func angleForColor(color: Color) -> Int
}

struct RYBColorWheel: ColorWheelType {
  static func colorAtAngle(angle: Int) -> Color {
    return RGBColorWheel.colorAtAngle(angle).convertRGBToRYB()
  }
  
  static func colorAtAngle(defaultColor: Color, angle: Int) -> Color {
    return RGBColorWheel.colorAtAngle(defaultColor, angle: angle).convertRGBToRYB()
  }
  
  static func angleForColor(color: Color) -> Int {
    return RYBColorModel.angleFromColor(color)
  }
}

struct RGBColorWheel: ColorWheelType {
  static func colorAtAngle(angle: Int) -> Color {
    let rightAngle = Int(optimizeAngle(angle))
    return Color(hue: rightAngle, saturation: 1.0, brightness: 1.0)
  }
  
  static func colorAtAngle(defaultColor: Color, angle: Int) -> Color {
    let color = colorAtAngle(angle)
    let hue = color.hsb.hue
    let defaultHSB = defaultColor.hsb
    return Color(hue: hue, saturation: defaultHSB.saturation, brightness: defaultHSB.brightness, alpha: defaultColor.alpha.toCGFloat())
  }
  
  static func angleForColor(color: Color) -> Int {
    return color.hsb.hue
  }
}

private func optimizeAngle(angle: Int) -> UInt {
  let optimizeAngleValue: Int
  if angle < 0 {
    optimizeAngleValue = (360 - angle) % 360
  } else {
    optimizeAngleValue = angle % 360
  }
  return UInt(optimizeAngleValue)
}