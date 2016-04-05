//
//  Color+RYB.swift
//  Rainbow
//
//  Created by Alex Zimin on 05/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

extension Color {
  convenience init(red: Float, yellow: Float, blue: Float, alpha: Float = 1) {
    let rgb = toRGB(red, yellow: yellow, blue: blue)
    self.init(red: rgb.0, green: rgb.1, blue: rgb.2, alpha: alpha)
  }
}

private func toRGB(red: Float, yellow: Float, blue: Float) -> (Float, Float, Float) {
  var r, y, b, g, w, my, mg, n: Float
  r = red
  y = yellow
  b = blue
  
  // remove whiteness
  w = min(r, y, b)
  r -= w
  y -= w
  b -= w
  
  my = max(r, y, b)
  
  // Get the green out of the yellow and blue
  g = min(y, b)
  y -= g
  b -= g
  
  if b > 0 && g > 0 {
    b *= 2.0
    g *= 2.0
  }
  
  // Redistribute the remaining yellow.
  r += y
  g += y
  
  // Normalize to values.
  mg = max(r, g, b)
  if mg > 0 {
    n = my / mg
    r *= n
    g *= n
    b *= n
  }
  
  // Add the white back in.
  r += w
  g += w
  b += w
  
  return (r, g, b)
}

private func toRGB2(red: Float, yellow: Float, blue: Float) -> (Float, Float, Float) {
  func cubicInterpolation(t: Float, a: Float, b: Float) -> Float {
    return (a + (t * t * (3.0 - 2.0 * t)) * (b - a))
  }
  
  var x0 = cubicInterpolation(blue, a: 1.0, b: 0.163)
  var x1 = cubicInterpolation(blue, a: 1.0, b: 0.0)
  var x2 = cubicInterpolation(blue, a: 1.0, b: 0.5)
  var x3 = cubicInterpolation(blue, a: 1.0, b: 0.2)
  var y0 = cubicInterpolation(yellow, a: x0, b: x1)
  var y1 = cubicInterpolation(yellow, a: x2, b: x3)
  let red = cubicInterpolation(red, a: y0, b: y1)
  
  x0 = cubicInterpolation(blue, a: 1.0, b: 0.373)
  x1 = cubicInterpolation(blue, a: 1.0, b: 0.66)
  x2 = cubicInterpolation(blue, a: 0.0, b: 0.0)
  x3 = cubicInterpolation(blue, a: 0.5, b: 0.094)
  y0 = cubicInterpolation(yellow, a: x0, b: x1)
  y1 = cubicInterpolation(yellow, a: x2, b: x3)
  let green = cubicInterpolation(red, a: y0, b: y1)
  
  x0 = cubicInterpolation(blue, a: 1.0, b: 0.6)
  x1 = cubicInterpolation(blue, a: 0.0, b: 0.2)
  x2 = cubicInterpolation(blue, a: 0.0, b: 0.5)
  x3 = cubicInterpolation(blue, a: 0.0, b: 0.0)
  y0 = cubicInterpolation(yellow, a: x0, b: x1)
  y1 = cubicInterpolation(yellow, a: x2, b: x3)
  let blue = cubicInterpolation(red, a: y0, b: y1)
  
  return sanitize(red, g: green, b: blue)
}

private func sanitize(r: Float, g: Float, b: Float) -> (Float, Float, Float) {
  var red: Float = r
  var green: Float = g
  var blue: Float = b
  
  red = 0 != signbit(red) ? red * -1.0 : red
  red = (1.0 > (red * (100000.0))) ? 0.0 : (1.0 < red) ? 1.0 : red
  
  green = 0 != (signbit(green)) ? green * -1.0 : green
  green = (1.0 > (green * (100000.0))) ? 0.0 : (1.0 < green) ? 1.0 : green
  
  blue = 0 != (signbit(blue)) ? blue * -1.0 : blue;
  blue = (1.0 > (blue * (100000.0))) ? 0.0 : (1.0 < blue) ? 1.0 : blue
  
  return (red, green, blue)
}