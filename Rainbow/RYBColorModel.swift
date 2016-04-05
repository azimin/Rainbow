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
    static var red: Color = Color.redColor()
    static var vermilion: Color = Color(hexString: "ff4000")
    static var orange: Color = Color(hexString: "ff8000")
    static var amber: Color = Color(hexString: "ffbf00")
    static var yellow: Color = Color(hexString: "ffff00")
    static var chartreuse: Color = Color(hexString: "81d41a")
    static var green: Color = Color(hexString: "00a933")
    static var teal: Color = Color(hexString: "158466")
    static var blue: Color = Color(hexString: "2a6099")
    static var violet: Color = Color(hexString: "55308d")
    static var purple: Color = Color(hexString: "800080")
    static var mangenta: Color = Color(hexString: "bf0041")
    
    static func colorsAtAngle(angle: UInt) -> ((Color, Color), Float) {
      let optimizeAngle = angle % 360      
      
      let colors = [red, vermilion, orange, amber, yellow, chartreuse, green, teal, blue, violet, purple, mangenta]
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
  }
}