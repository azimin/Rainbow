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
  
  init() {
    self.init(colorWheel: RYBColorWheel.self)
  }
  
  func takeSameStyleOfColor(color originColor: Color, forColorOnAngle color: Color) -> Color {
    let angle = colorWheel.angleForColor(color)
    return colorWheel.colorAtAngle(originColor, angle: angle)
  }
  
  // Hight contrast
  func complementary(color: Color) -> (original: Color, complementary: Color) {
    let angle = colorWheel.angleForColor(color)
    let complementaryColor = colorWheel.colorAtAngle(color, angle: angle + 180)
    return (color, complementaryColor)
  }
  
  // Two less contrast colors
  func splitComplementary(color: Color, movementAngle: Int = 30) -> (original: Color, complementaryRight: Color, complementaryLeft: Color) {
    let angle = colorWheel.angleForColor(color)
    let firstColor = colorWheel.colorAtAngle(color, angle: angle + (180 - movementAngle))
    let secondColor = colorWheel.colorAtAngle(color, angle: angle + (180 + movementAngle))
    return (color, firstColor, secondColor)
  }
  
  func rectangle(firstColor: Color, movementAngle: Int = 30) -> (firstPair: (Color, Color), secondPair: (Color, Color)) {
    let angle = colorWheel.angleForColor(firstColor)
    let secondAngle = angle + movementAngle 
    let secondColor = colorWheel.colorAtAngle(firstColor, angle: secondAngle)
    let firstPair = complementary(firstColor)
    let secondPair = complementary(secondColor)
    return (firstPair, secondPair)
  }
  
  // Narby colors
  func analogous(color: Color, movementAngle: Int = 30) -> (middle: Color, left: Color, right: Color) {
    let angle = colorWheel.angleForColor(color)
    let leftColor = colorWheel.colorAtAngle(color, angle: angle - 30)
    let rightColor = colorWheel.colorAtAngle(color, angle: angle + 30)
    return (color, leftColor, rightColor)
  }
  
  // Equal space on wheel
  func triadic(color: Color) -> (original: Color, left: Color, right: Color) {
    let angle = colorWheel.angleForColor(color)
    let leftColor = colorWheel.colorAtAngle(color, angle: angle - 120)
    let rightColor = colorWheel.colorAtAngle(color, angle: angle + 120)
    return (color, leftColor, rightColor)
  }
}