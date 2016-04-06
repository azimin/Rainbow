//
//  ColorMessagePlate.swift
//  Rainbow
//
//  Created by Alex Zimin on 07/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

enum ColorsPlate {
  case Red
  case Mangenta
  case Purple
  case Violet
  case Blue
  case Teal
  case Green
  case Chartreuse
  case Yellow
  case Amber
  case Orange
  case Vermilion
  
  var color: Color {
    switch self {
    case .Red:
      return RYBColorModel.DefaultColorsCollection.red
    case .Mangenta:
      return RYBColorModel.DefaultColorsCollection.mangenta
    case .Purple:
      return RYBColorModel.DefaultColorsCollection.purple
    case .Violet:
      return RYBColorModel.DefaultColorsCollection.violet
    case .Blue:
      return RYBColorModel.DefaultColorsCollection.blue
    case .Teal:
      return RYBColorModel.DefaultColorsCollection.teal
    case .Green:
      return RYBColorModel.DefaultColorsCollection.green
    case .Chartreuse:
      return RYBColorModel.DefaultColorsCollection.chartreuse
    case .Yellow:
      return RYBColorModel.DefaultColorsCollection.yellow
    case .Amber:
      return RYBColorModel.DefaultColorsCollection.amber
    case .Orange:
      return RYBColorModel.DefaultColorsCollection.orange
    case .Vermilion:
      return RYBColorModel.DefaultColorsCollection.vermilion
    }
  }
}

struct ColorMessagePlate: ColorMessageGenericType {
  
  typealias Generated = Color
  func execute(color: Color) -> Color {
    return ColorWheelAction().takeSameStyleOfColor(color: color, forColorOnAngle: colorOnPlate)
  }
  
  let colorOnPlate: Color
  
  init(colorPlate: ColorsPlate) {
    self.colorOnPlate = colorPlate.color
  }
  
  init(color: Color) {
    self.colorOnPlate = color
  }
}