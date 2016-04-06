//
//  Float-Extensions.swift
//  Rainbow
//
//  Created by Alex Zimin on 20/03/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

internal extension Float {
  func toCGFloat() -> CGFloat {
    return CGFloat(self)
  }
  
  func toDouble() -> Double {
    return Double(self)
  }
}

internal func C(a: Float, b: Float) -> Float {
  return sqrt(pow(a, 2) + pow(b, 2))
}

extension Float {
  static func random() -> Float {
    return Double.random().toFloat()
  }
}