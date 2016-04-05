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
  func complementary(color: Color) -> Color {
    return colorWheel.colorAtAngle(color, angle: 180)
  }
  
  // Two less contrast colors
  func splitComplementary (color: Color) -> (Color, Color) {
    let firstColor = colorWheel.colorAtAngle(color, angle: 150)
    let secondColor = colorWheel.colorAtAngle(color, angle: 210)
    return (firstColor, secondColor)
  }
  
}