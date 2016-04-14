//
//  Color+Contrast.swift
//  Rainbow
//
//  Created by Alex Zimin on 06/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

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
    
    if hsb.brightness > 0.84 {
      hsb.brightness = 0.84
    }
    
    if hsb.saturation > 0.82 {
      hsb.saturation = 0.82
    }
    
    return Color(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness)
  }
  
  func minimalColor() -> Color {
    let rgbValue = self.RGBVector
    if rgbValue.x == rgbValue.y {
      if rgbValue.y == rgbValue.x {
        return self
      }
    }
    
    let hsb = self.hsb
    
    return Color(hue: hsb.hue, saturation: 0.38, luminosity: 0.55)
  }
  
  private func optimizeAngle(angle: Int) -> UInt {
    let optimizeAngleValue: Int
    if angle < 0 {
      optimizeAngleValue = (360 - angle) % 360
    } else {
      optimizeAngleValue = angle % 360
    }
    return UInt(optimizeAngleValue)
  }
  
  func contrastRandomColor() -> Color {
    let randomColor = Color.randomColor(self.isDarkColor)
    var hsl = self.hsl
    
    if self.isDarkColor {
      hsl.luminosity += 0.22
    } else {
      hsl.luminosity -= 0.35
    }
    
    return Color(hue: randomColor.hsl.hue, saturation: hsl.saturation, luminosity: hsl.luminosity)
  }
  
//  func contrastRandomColor2(powerfull: Float = 1.0) -> Color {
//    let isLight = !self.isDarkColor
//    var random = Color.randomColor()
//    
//    while true {
//      random = Color.randomColor()
//      let randHue = random.hsb.hue
//      let hue = self.hsb.hue
//      
//      let angle = optimizeAngle(randHue - hue)
//      
//      if !isLight {
//        if angle < 360 && angle > 135 {
//          continue
//        }
//      }
//      
//      if angle > 30 {
//        break
//      }
//    }
//    
//    var brightness = self.hsb.brightness
//    var saturation = random.hsb.saturation
//    var additional: Float = 0
//    
//    if brightness < 0.2 {
//      additional = 0.2
//    } else if brightness > 0.8 {
//      additional = -0.2
//    }
//    
//    if isLight {
//      brightness -= (0.25 * powerfull)
//    } else {
//      brightness += (0.25 * powerfull)
//      saturation = self.hsb.saturation - (self.hsb.saturation * 0.25) - 0.25
//    }
//    brightness += additional
//    
//    return Color(hue: random.hsb.hue, saturation: saturation, brightness: brightness)
//  }
  
  func contrast() -> Color {
    var hsb = self.hsb
    
    if hsb.brightness > 0.5 {
      hsb.brightness = hsb.brightness * 0.7 - 0.05
    } else {
      hsb.brightness = max((hsb.brightness + 0.1), 0.3) * 1.2
    }
    
    if hsb.saturation > 0.5 {
      hsb.saturation = hsb.brightness * 0.7 - 0.05
    } else {
      hsb.saturation = max((hsb.saturation + 0.1), 0.3) * 1.2
    }
    
    return Color(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness)
  }
  
  func changeContrastValue(value: Float) -> Color {
    var hsb = self.hsl
    hsb.luminosity += value
    return Color(hue: hsb.hue, saturation: hsb.saturation, luminosity: hsb.luminosity)
  }
  
  func shouldUseBorder(color: Color) -> Bool {
    let value = ColorCompare(firstColor: self, secondColor: color).CIE2000
    return value < 20
  }
}