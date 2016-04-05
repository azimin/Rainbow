//
//  UCColorGradientTemplate.swift
//  GetColorBetween
//
//  Created by Alex Zimin on 18/03/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

/*
  Alexander Zimin (azimin)
  Example of generating 5 colors between red and blue:

  let gradientTemplate = UCColorGradientTemplate(startColor: UIColor.redColor(), endColor: UIColor.blueColor())
  let colors = gradientTemplate.getColorsWithNumberOfSteps(5)

*/

struct ColorGradientTemplate {
  private typealias colorRGBComponents = (red: Float, green: Float, blue: Float)
  
  private var startColorComponents: colorRGBComponents
  private var endColorComponents: colorRGBComponents
  
  init(startColor: Color, endColor: Color) {
    startColorComponents = (red: startColor.red(), green: startColor.green(), blue: startColor.blue())
    endColorComponents = (red: endColor.red(), green: endColor.green(), blue: endColor.blue())
  }
  
  /*
    return color that locate between `startColor` and `endColor`
    0 <= percent <= 1
  */
  func getColorBetweenWithPercentMove(percent: Float) -> Color {
    assert(percent >= 0, "Percent must be more or equal than 0")
    assert(percent <= 1, "Percent must be lest or equal than 1")
    
    let red = startColorComponents.red + percent * (endColorComponents.red - startColorComponents.red)
    let green = startColorComponents.green + percent * (endColorComponents.green - startColorComponents.green)
    let blue = startColorComponents.blue + percent * (endColorComponents.blue - startColorComponents.blue)
    
    return Color(red: red, green: green, blue: blue)
  }
  
  /*
    return array of colors that located between `startColor` and `endColor` (included bounds)
    numberOfSteps >= 2
  */
  func getColorsWithNumberOfSteps(numberOfSteps: Int) -> [Color] {
    assert(numberOfSteps >= 2, "Number of steps must be more or equal than 2")
    
    let step = 1 / Float(numberOfSteps - 1)
    var colors = [Color]()
    
    for i in 0..<numberOfSteps {
      let color = getColorBetweenWithPercentMove(step * Float(i))
      colors.append(color)
    }
    
    return colors
  }
}
