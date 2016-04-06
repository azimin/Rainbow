//
//  RYBColorModel.swift
//  Rainbow
//
//  Created by Alex Zimin on 05/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

private let angleStep: UInt = 360 / 12

struct RYBColorModel {
  struct DefaultColorsCollection {
    static var red: Color {
      return Color(hexString: "FF0000")
    }
    static var vermilion: Color {
      return Color(hexString: "FF7400")
    }
    static var orange: Color {
      return Color(hexString: "FFAA00")
    }
    static var amber: Color {
      return  Color(hexString: "FFD300")
    }
    static var yellow: Color {
      return Color(hexString: "FFFF00")
    }
    static var chartreuse: Color {
      return  Color(hexString: "9FEE00")
    }
    static var green: Color {
      return Color(hexString: "00CC00")
    }
    static var teal: Color {
      return Color(hexString: "009999")
    }
    static var blue: Color {
      return Color(hexString: "1240AB")
    }
    static var violet: Color {
      return Color(hexString: "3914AF")
    }
    static var purple: Color {
      return Color(hexString: "7109AA")
    }
    static var mangenta: Color {
      return Color(hexString: "CD0074")
    }
    
    static let colors = [red, vermilion, orange, amber, yellow, chartreuse, green, teal, blue, violet, purple, mangenta]
  }
  
  static var colors: [Color] {
    return DefaultColorsCollection.colors
  }
  
  static var colorsLABs: [LABColor] = {
    return colors.map({ (color) -> LABColor in
      return LABColor(color: color)
    })
  }()
  
  static func colorsAtAngle(angle: UInt) -> ((Color, Color), Float) {
    let optimizeAngle = angle % 360      
    let index = optimizeAngle / angleStep
    let nextIndex = index == 11 ? 0 : index + 1
    
    let delta = Float(angle % angleStep)
    let movement: Float
    if delta == 0 {
      movement = 0
    } else {
      movement = delta / Float(angleStep)
    }
    
    return ((colors[Int(index)], colors[Int(nextIndex)]), movement)
  }
  
  static func angleFromColor(color: Color) -> Int {
    return RYBColorModelAngleToHue.RYBStopToHSVStopMap(color.hsl.hue)
  }
}