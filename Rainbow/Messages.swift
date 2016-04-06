//
//  Messages.swift
//  Rainbow
//
//  Created by Alex Zimin on 06/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

struct Message {
  static var whiteOrBlackContrast: ColorMessageContrast {
    return ColorMessageContrast()
  }
  
  static func getSuchColor(colorOnPlate: ColorsPlate) -> ColorMessagePlate {
    return ColorMessagePlate(colorPlate: colorOnPlate)
  }
  
  static func getSuchColor(color: Color) -> ColorMessagePlate {
    return ColorMessagePlate(color: color)
  }
}