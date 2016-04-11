//
//  ColorNamesCollection.swift
//  Rainbow
//
//  Created by Alex Zimin on 11/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

private struct ColorInCollection {
  var name: String
  var rgb: Vector3D
}

class ColorNamesCollection {
  private static var colors: [ColorInCollection] = {
    var result = [ColorInCollection]()
    
    var error: NSError?
    
    let url = NSBundle.mainBundle().URLForResource("colors", withExtension: "csv")!
    let fileText = try! String(contentsOfURL: url, encoding: NSUTF8StringEncoding)
    let colors = fileText.componentsSeparatedByString("\n")
    for colorLine in colors {
      let colorInfo = colorLine.componentsSeparatedByString(",")
      if colorInfo.count != 6 {
        continue
      }
      
      let red = Float(colorInfo[3])! / 255
      let green = Float(colorInfo[4])! / 255
      let blue = Float(colorInfo[5])! / 255
      
      let color = ColorInCollection(name: colorInfo[1], rgb: Vector3D(x: red, y: green, z: blue))
      result.append(color)
    }
    
    return result
  }()
  
  static func getColorName(color: Color) -> String {
    let colorVector = Vector3D(tuple: color.RGBVector.toFloatTuple())
    let distanceFunc = distanceForAccuracy(.Low)
    
    var minIndex = 0
    var minValue: Float = Float(Int.max)
    
    for (index, color) in colors.enumerate() {
      let distance = distanceFunc(color.rgb, colorVector)
      if distance < minValue {
        minIndex = index
        minValue = distance
      }
    }
    
    return colors[minIndex].name
  }
}