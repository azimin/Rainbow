//
//  ColorWheelImageDrawer.swift
//  Rainbow
//
//  Created by Alex Zimin on 11/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class ColorWheelImageDrawer {
  static func drawImage(size: CGSize, colorWheel: ColorWheelType.Type) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
    UIColor.whiteColor().setFill()
    UIRectFill(CGRect(origin: CGPoint(x: 0, y: 0), size: size))
    
    let sectors = 360
    let radius = min(size.height, size.width) / 2 - 2
    let angle: CGFloat = 2 * CGFloat(M_PI) / CGFloat(sectors)
    
    let center = CGPoint(x: size.width / 2, y: size.height / 2)
    let startAngle = angle * -90
    
    for i in 0..<sectors {
      let bezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle + CGFloat(i) * angle, endAngle: startAngle + CGFloat(i + 1) * angle, clockwise: true)
      bezierPath.addLineToPoint(center)
      bezierPath.closePath()
      
      let color = colorWheel.colorAtAngle(360 / sectors * i)
      color.UIColorValue.setFill()
      color.UIColorValue.setStroke()
      
      bezierPath.fill()
      bezierPath.stroke()
    }
    
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return img
  }
}