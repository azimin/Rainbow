//
//  Double-Extensions.swift
//  Rainbow
//
//  Created by Alex Zimin on 20/03/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

internal extension Double {
  func toCGFloat() -> CGFloat {
    return CGFloat(self)
  }
  
  func toFloat() -> Float {
    return Float(self)
  }
}