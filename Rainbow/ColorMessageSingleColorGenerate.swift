//
//  ColorMessagePlate.swift
//  Rainbow
//
//  Created by Alex Zimin on 07/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

struct ColorMessageSingleColorGenerate: ColorMessageGenericType {
  typealias Generated = Color
  func execute(color: Color) -> Color {
    return ColorWheelAction().takeSameStyleOfColor(color: color, forColorOnAngle: colorOnPlate)
  }
  
  let colorOnPlate: Color
  
  init(colorPlate: RYBColorPlate) {
    self.colorOnPlate = colorPlate.color
  }
  
  init(color: Color) {
    self.colorOnPlate = color
  }
}