//
//  ColorWheelBasicActions.swift
//  Rainbow
//
//  Created by Alex Zimin on 05/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

struct ColorWheelAction {
  let colorWheel: ColorWheelType.Type
  init(colorWheel: ColorWheelType.Type) {
    self.colorWheel = colorWheel
  }
  
  // Hight contrast
  func complementary(color: Color) -> (color: Color, complementary: Color) {
    let angle = colorWheel.angleForColor(color)
    let complementaryColor = colorWheel.colorAtAngle(color, angle: angle + 180)
    return (color, complementaryColor)
  }
  
  // Two less contrast colors
  func splitComplementary(color: Color) -> (color: Color, complementaryRight: Color, complementaryLeft: Color) {
    let angle = colorWheel.angleForColor(color)
    let firstColor = colorWheel.colorAtAngle(color, angle: angle - 30)
    let secondColor = colorWheel.colorAtAngle(color, angle: angle + 30)
    return (color, firstColor, secondColor)
  }
  
  enum RectangleColorSchemeSecondColorLocation {
    case Right
    case Left
  }
  
  func rectangle(firstColor: Color, secondColorLocation: RectangleColorSchemeSecondColorLocation = .Right) -> (firstPair: (Color, Color), secondPair: (Color, Color)) {
    let angle = colorWheel.angleForColor(firstColor)
    let secondAngle = (secondColorLocation == .Right) ? angle + 30 : angle - 30 
    let secondColor = colorWheel.colorAtAngle(firstColor, angle: secondAngle)
    let firstPair = complementary(firstColor)
    let secondPair = complementary(secondColor)
    return (firstPair, secondPair)
  }
}