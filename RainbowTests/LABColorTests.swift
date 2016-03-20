//
//  LABColorTests.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import XCTest
@testable import Rainbow


typealias RGBColorSet = (red: Float, green: Float, blue: Float)
typealias LABColorSet = (l: Float, a: Float, b: Float)

let eps: Float = 0.01

var testRGBToLABPairs: [(rgb: RGBColorSet, lab: LABColorSet)] =
[((0.65, 0.35, 0.9), (52.8964, 56.1483, -59.2251)),
((0, 0, 0), (-5.96046e-08, 0, 0)),
((0.005, 0.99, 0.35), (87.3086, -80.933, 62.1952))]

class LABColorTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testRGBToLAB() {
    for values in testRGBToLABPairs {
      let rgbPair = values.rgb
      let color = Color(red: rgbPair.red, green: rgbPair.green, blue: rgbPair.blue)
      compare(LABColor(color: color), value: values.lab)
    }
  }
  
  func testLABToRGB() {
    for values in testRGBToLABPairs {
      let labPair = values.lab
      let labColor = LABColor(l: labPair.l, a: labPair.a, b: labPair.b)
      compare(labColor.color, value: values.rgb)
    }
  }
  
  func compare(color: LABColor, value: LABColorSet) {
    let value = abs(color.l - value.l) + abs(color.a - value.a) + abs(color.b - value.b)
    assert(value < eps, "Wrong LAB calculation value")
  }
  
  func compare(color: Color, value: RGBColorSet) {
    let value = abs(color.red() - value.red) + abs(color.green() - value.green) + abs(color.blue() - value.blue)
    assert(value < eps, "Wrong RGB calculation value")
  }
  
}
