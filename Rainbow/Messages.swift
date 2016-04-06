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
  
  static func getSuchColor(colorOnPlate: RYBColorPlate) -> ColorMessageSingleColorGenerate {
    return ColorMessageSingleColorGenerate(colorPlate: colorOnPlate)
  }
  
  static func getSuchColor(color: Color) -> ColorMessageSingleColorGenerate {
    return ColorMessageSingleColorGenerate(color: color)
  }
  
  static var effect: ColorMessageEffect.Type {
    return ColorMessageEffect.self
  }
}