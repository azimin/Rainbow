//
//  Color+HSB.swift
//  Rainbow
//
//  Created by Alex Zimin on 05/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

extension Color {
  var hsb: Optimize3DCGFloatVector {
    var hsb: (h: CGFloat, s: CGFloat, b: CGFloat) = (0, 0, 0)
    UIColor.blackColor().getHue(&(hsb.h), saturation: &(hsb.s), brightness: &(hsb.b), alpha: nil)
    return Optimize3DCGFloatVector(x: hsb.h, y: hsb.s, z: hsb.b)
  }
  
  convenience init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat = 1) {
    let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    self.init(color: color)!
  }
}