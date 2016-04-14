//
//  ColorCollection.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

// Basic

extension Color {
  static func blackColor() -> Color {
    return Color(red: 0.0, green: 0, blue: 0)
  }
  
  static func whiteColor() -> Color {
    return Color(red: 1.0, green: 1, blue: 1)
  }
  
  static func lightGreyColor() -> Color {
    return Color(hexString: "D8D8D8")
  }
  
  static func yellowColor() -> Color {
    return Color(red: 1.0, green: 1, blue: 0)
  }
  
  static func redColor() -> Color {
    return Color(red: 1.0, green: 0, blue: 0)
  }
  
  static func greenColor() -> Color {
    return Color(red: 0.0, green: 1, blue: 0)
  }
  
  static func blueColor() -> Color {
    return Color(red: 0.0, green: 0, blue: 1)
  }
  
  static func randomColor() -> Color {
    return Color(red: Float.random(), green: Float.random(), blue: Float.random())
  }
  
  static func randomColor(isDark:Bool) -> Color {
    let randomColor = Color.randomColor()
    let angle: Int
    if isDark {
      angle = -20 + Int(Float.random() * 180)
    } else {
      angle = 160 + Int(Float.random() * 180)
    }
    return RYBColorWheel.colorAtAngle(randomColor, angle: angle)
  }
}

// Complex

extension Color {
  
}