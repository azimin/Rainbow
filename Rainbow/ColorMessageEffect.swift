//
//  ColorMessageEffect.swift
//  Rainbow
//
//  Created by Alex Zimin on 07/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

enum ColorMessageEffect: ColorMessageGenericType {
  typealias Generated = Color
  
  case LessContrast
  case MoreContrast
  case NotVeryContrast
  case ElementColor
  case BorderColor
  
  func execute(color: Color) -> Color {
    let rectange = ColorWheelAction().analogous(color, movementAngle: 60)
    
    switch self {
    case .ElementColor:
      return rectange.left
    case .BorderColor:
      return rectange.right
    case .LessContrast:
      return color.changeContrastValue(-0.1)
    case .MoreContrast:
      return color.changeContrastValue(0.1)
    case .NotVeryContrast:
      return color.balancedColor()
    }
  }
}