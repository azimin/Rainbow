//
//  Dictionary-Extensions.swift
//  Rainbow
//
//  Created by Alex Zimin on 06/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

extension Dictionary where Value : Equatable {
  func firstKeyForValue(val: Value) -> Key? {
    for (key, value) in self {
      if val == value {
        return key
      }
    }
    return nil
  }
}

extension Dictionary where Value : Hashable {
  func reverseDictionary() -> [Value: Key] {
    var result = [Value: Key]()
    for (key, value) in self {
      result[value] = key
    }
    return result
  }
}