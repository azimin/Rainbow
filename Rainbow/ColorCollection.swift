//
//  ColorCollection.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

extension Color {
  static func blackColor() -> Color {
    return Color(hexString: "000000")
  }
  
  static func redColor() -> Color {
    return Color(hexString: "FF0000")
  }
  
  static func greenColor() -> Color {
    return Color(hexString: "00FF00")
  }
  
  static func blueColor() -> Color {
    return Color(hexString: "0000FF")
  }
}