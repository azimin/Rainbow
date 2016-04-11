//
//  Color+RGB.swift
//  Rainbow
//
//  Created by Alex Zimin on 20/03/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

extension Color {  
  func red() -> Float {
    return RGBVector.x
  }
  
  func green() -> Float {
    return RGBVector.y
  }
  
  func blue() -> Float {
    return RGBVector.z
  }
  
  func red() -> CGFloat {
    return RGBVector.x.toCGFloat()
  }
  
  func green() -> CGFloat {
    return RGBVector.y.toCGFloat()
  }
  
  func blue() -> CGFloat {
    return RGBVector.z.toCGFloat()
  }
  
  func red() -> Double {
    return RGBVector.x.toDouble()
  }
  
  func green() -> Double {
    return RGBVector.x.toDouble()
  }
  
  func blue() -> Double {
    return RGBVector.x.toDouble()
  }
}