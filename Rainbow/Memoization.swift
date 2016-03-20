//
//  Memoization.swift
//  Rainbow
//
//  Created by Alex Zimin on 20/03/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

func memoize<T: Hashable, U>(f: T -> U) -> (T -> U) {
  var cache = [T : U]()
  return { 
    key in
    var value = cache[key]
    if value == nil {
      value = f(key)
      cache[key] = value
    }
    return value!
  }
}
