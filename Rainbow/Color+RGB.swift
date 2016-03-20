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
    return self.floatRGBVector.red
  }
  
  func green() -> Float {
    return self.floatRGBVector.green
  }
  
  func blue() -> Float {
    return self.floatRGBVector.blue
  }
  
  func red() -> CGFloat {
    return self.cgfloatRGBVector.red
  }
  
  func green() -> CGFloat {
    return self.cgfloatRGBVector.green
  }
  
  func blue() -> CGFloat {
    return self.cgfloatRGBVector.blue
  }
  
  func red() -> Double {
    return self.doubleRGBVector.red
  }
  
  func green() -> Double {
    return self.doubleRGBVector.green
  }
  
  func blue() -> Double {
    return self.doubleRGBVector.blue
  }
}