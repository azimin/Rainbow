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
  
  func execute(color: Color) -> Color {
    return color.balancedColor()
  }
}