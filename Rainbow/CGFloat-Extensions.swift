//
//  CGFloat.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

extension CGFloat {
  var color256Number: Int {
    set {
      self = CGFloat(newValue / 255)
    }
    get {
      return Int(self * 255)
    }
  }
}

internal extension CGFloat {
  func toFloat() -> Float {
    return Float(self)
  }
  
  func toDouble() -> Double {
    return Double(self)
  }
}

extension CGFloat {
  var degreesToRadians: CGFloat {
    return self * CGFloat(M_PI) / 180.0
  }
}