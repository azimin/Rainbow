//
//  RainbowTests.swift
//  RainbowTests
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import XCTest
@testable import Rainbow

var numberOfMeasures = 1000000

class PerformanceTests: XCTestCase {
  
  func testUIColorPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      for _ in 0..<numberOfMeasures {
        _ = UIColor(red: 0.5, green: 0.55, blue: 0.45, alpha: 1.0)
      }
    }
  }
  
  func testLabColorPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      for _ in 0..<numberOfMeasures {
        _ = Color(red: 0.5, green: 0.55, blue: 0.45)
        _ = Color(l: 0.5, a: 0.5, b: -0.4)
      }
    }
  }
  
  func testColorActionPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      for _ in 0..<numberOfMeasures {
        let color = Color(red: 0.5, green: 0.55, blue: 0.45)
        _ = color.hsl
        _ = color.contrastingBlackOrWhite()
      }
    }
  }
}
