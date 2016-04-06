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
      return Color(hexString: "FF3F00")
    }
    static var orange: Color {
      return Color(hexString: "FF7F00")
    }
    static var amber: Color {
      return  Color(hexString: "FFBF00")
    }
    static var yellow: Color {
      return Color(hexString: "FFFF00")
    }
    static var chartreuse: Color {
      return  Color(hexString: "7FD319")
    }
    static var green: Color {
      return Color(hexString: "00A832")
    }
    static var teal: Color {
      return Color(hexString: "148365")
    }
    static var blue: Color {
      return Color(hexString: "295F99")
    }
    static var violet: Color {
      return Color(hexString: "542F8C")
    }
    static var purple: Color {
      return Color(hexString: "7F007F")
    }
    static var mangenta: Color {
      return Color(hexString: "BF003F")
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
    return RYBColorModelAngleToHue.hueToAngle(color.hsl.hue)
  }
}