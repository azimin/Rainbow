//
//  Color+RYB.swift
//  Rainbow
//
//  Created by Alex Zimin on 05/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

typealias RYB = (red: Float, yellow: Float, blue: Float)

extension Color {
  convenience init(red: Float, yellow: Float, blue: Float, alpha: Float = 1) {
    let rgb = toRGB(red, yellow: yellow, blue: blue)
    self.init(red: rgb.0, green: rgb.1, blue: rgb.2, alpha: alpha)
  }
  
  func convertRGBToRYB() -> Color {
    let values = self.RGBVector.toFloatTuple()
    return Color(red: values.0, yellow: values.1, blue: values.2)
  }
}

private var magicColors: [[Float]] = [
  [1,     1,     1],
  [1,     1,     0],
  [1,     0,     0],
  [1,     0.5,   0],
  [0.163, 0.373, 0.6],
  [0.0,   0.66,  0.2],
  [0.5,   0.0,   0.5],
  [0.2,   0.094, 0.0]
]

// http://bahamas10.github.io/ryb/about.html

private func toRGB(red: Float, yellow: Float, blue: Float) -> (Float, Float, Float) {
  func cubicInterpolation(t: Float, _ A: Float, _ B: Float) -> Float {
    let weight = t * t * (3 - 2 * t)
    return A + weight * (B - A)
  }
  
  func getRed(iR: Float, _ iY: Float, _ iB: Float) -> Float {
    let magic = magicColors
    
    let x0 = cubicInterpolation(iB, magic[0][0], magic[4][0])
    let x1 = cubicInterpolation(iB, magic[1][0], magic[5][0])
    let x2 = cubicInterpolation(iB, magic[2][0], magic[6][0])
    let x3 = cubicInterpolation(iB, magic[3][0], magic[7][0])
    let y0 = cubicInterpolation(iY, x0, x1)
    let y1 = cubicInterpolation(iY, x2, x3)
    return cubicInterpolation(iR, y0, y1)
  }
  
  func getGreen(iR: Float, _ iY: Float, _ iB: Float) -> Float {
    let magic = magicColors
    
    let x0 = cubicInterpolation(iB, magic[0][1], magic[4][1])
    let x1 = cubicInterpolation(iB, magic[1][1], magic[5][1])
    let x2 = cubicInterpolation(iB, magic[2][1], magic[6][1])
    let x3 = cubicInterpolation(iB, magic[3][1], magic[7][1])
    let y0 = cubicInterpolation(iY, x0, x1)
    let y1 = cubicInterpolation(iY, x2, x3)
    return cubicInterpolation(iR, y0, y1)
  }
  
  func getBlue(iR: Float, _ iY: Float, _ iB: Float) -> Float {
    let magic = magicColors
    
    let x0 = cubicInterpolation(iB, magic[0][2], magic[4][2])
    let x1 = cubicInterpolation(iB, magic[1][2], magic[5][2])
    let x2 = cubicInterpolation(iB, magic[2][2], magic[6][2])
    let x3 = cubicInterpolation(iB, magic[3][2], magic[7][2])
    let y0 = cubicInterpolation(iY, x0, x1)
    let y1 = cubicInterpolation(iY, x2, x3)
    return cubicInterpolation(iR, y0, y1)
  }
  
  let r = getRed(red, yellow, blue)
  let g = getGreen(red, yellow, blue)
  let b = getBlue(red, yellow, blue)
  
  return (r, g, b)
}
