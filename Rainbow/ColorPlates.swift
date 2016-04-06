//
//  ColorPlate.swift
//  Rainbow
//
//  Created by Alex Zimin on 07/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

protocol ColorPlateType {
  var color: Color { get }
}

enum RYBColorPlate: ColorPlateType {
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

enum RGBColorPlate: ColorPlateType {
  case Red
  case Green
  case Blue
  
  var color: Color {
    switch self {
    case .Red:
      return Color.redColor()
    case .Green:
      return Color.greenColor()
    case .Blue:
      return Color.blueColor()
    }
  }
}