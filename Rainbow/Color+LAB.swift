//
//  Color+LAB.swift
//  Rainbow
//
//  Created by Alex Zimin on 11/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

typealias LAB = (l: Float, a: Float, b: Float)

extension Color {
  var lab: LAB {
    return LABColor(rgbVector: self.RGBVector).toVector().toFloatTuple()
  }
  
  init(l: Float, a: Float, b: Float) {
    let labColor = LABColor(l: l, a: a, b: b)
    let rgb = labColor.color!.RGBVector.toFloatTuple()
    self.init(red: rgb.0, green: rgb.1, blue: rgb.2)
  }
}