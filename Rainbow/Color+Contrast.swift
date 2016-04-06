//
//  Color+Contrast.swift
//  Rainbow
//
//  Created by Alex Zimin on 06/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

extension Color {
  func contrastingBlackOrWhite() -> Color {
    return isDarkColor ? Color.whiteColor() : Color.blackColor()
  }
  
  // Relative luminance in colorimetric spaces - http://en.wikipedia.org/wiki/Luminance_(relative)
  var isDarkColor: Bool {
    let luminance: Float = self.red() * 0.2126 + self.green() * 0.7152 + self.blue() * 0.0722
    return luminance < 0.6
  }
  
  // Make color less bright
  func balancedColor() -> Color {
    var hsb = self.hsb
    
    if hsb.brightness > 0.87 {
      hsb.brightness = 0.87
    }
    
    if hsb.saturation > 0.85 {
      hsb.saturation = 0.85
    }
    
    return Color(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness)
  }
}