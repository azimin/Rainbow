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