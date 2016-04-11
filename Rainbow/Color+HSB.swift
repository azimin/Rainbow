//
//  Color+HSB.swift
//  Rainbow
//
//  Created by Alex Zimin on 05/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

typealias HSB = (hue: Int, saturation: Float, brightness: Float)

extension Color {
  var hsb: HSB {
    var hsb: (h: CGFloat, s: CGFloat, b: CGFloat) = (0, 0, 0)
    self.UIColorValue.getHue(&(hsb.h), saturation: &(hsb.s), brightness: &(hsb.b), alpha: nil)
    return (Int(round(hsb.h * 360)), hsb.s.toFloat(), hsb.b.toFloat())
  }
  
  init(hue: Int, saturation: Float, brightness: Float, alpha: CGFloat = 1) {
    let realHue = Float(hue % 360) / 360.0
    let color = UIColor(hue: realHue.toCGFloat(), saturation: saturation.toCGFloat(), brightness: brightness.toCGFloat(), alpha: alpha)
    self.init(color: color)
  }
}