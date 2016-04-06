//
//  Color+HSV.swift
//  Rainbow
//
//  Created by Alex Zimin on 06/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//


// http://stackoverflow.com/questions/3018313/algorithm-to-convert-rgb-to-hsv-and-hsv-to-rgb-in-range-0-255-for-both/6930407#6930407 

import UIKit

typealias HSL = (hue: Int, saturation: Float, luminosity: Float)

extension Color {
  var hsl: HSL {
    var hsl: (h: Float, s: Float, l: Float) = (0, 0, 0) 
    RGB2HSL(self.red(), self.green(), self.blue(), &(hsl.h), &(hsl.s), &(hsl.l))
    return (Int(round(hsl.h * 360)), hsl.s, hsl.l) 
  }
  
  convenience init(hue: Int, saturation: Float, luminosity: Float, alpha: Float = 1) {
    let realHue = Float(hue % 360) / 360.0
    var rgb: (r: Float, g: Float, b: Float) = (0, 0, 0) 
    HSL2RGB(realHue, saturation, luminosity,  &(rgb.r), &(rgb.g), &(rgb.b))
    self.init(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: alpha)
  }
}

