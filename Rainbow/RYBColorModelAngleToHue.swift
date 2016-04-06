//
//  RYBColorModelAngleToHue.swift
//  Rainbow
//
//  Created by Alex Zimin on 06/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

struct RYBColorModelAngleToHue {
  static var RYBStopToHSVStop: [Int: Int] {
    return [
      0 : 0,
      60 : 120,
      180 : 120,
      240 : 240,
      360 : 360
    ]
  }
  
  static func RYBStopToHSVStopMap(value: Int) -> Int {
    let values = RYBStopToHSVStop
    let keys = values.values.sort()
    for (index, key) in keys.enumerate() {
      if key > value {
        let preveousKey = keys[index - 1]
        let preveousValue = values.firstKeyForValue(preveousKey)!
        let currentValue = values.firstKeyForValue(key)!
        
        var precentage: Float = 0
        if (value - preveousKey) != 0 {
          precentage = Float(value - preveousKey) / Float(key - preveousKey)
        }
        
        return Int(precentage * Float(currentValue - preveousValue)) + preveousValue
      }
    }
    return 0
  }
  
  static func HSVStopToRYBStopMap(value: Int) -> Int {
    let values = RYBStopToHSVStop.reverseDictionary()
    let keys = values.values.sort()
    for (index, key) in keys.enumerate() {
      if key > value {
        let preveousKey = keys[index - 1]
        let preveousValue = values.firstKeyForValue(preveousKey)!
        let currentValue = values.firstKeyForValue(key)!
        
        var precentage: Float = 0
        if (value - preveousKey) != 0 {
          precentage = Float(value - preveousKey) / Float(key - preveousKey)
        }
        
        return Int(precentage * Float(currentValue - preveousValue)) + preveousValue
      }
    }
    return 0
  }
}