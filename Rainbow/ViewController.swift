//
//  ViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 05/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBAction func sliderAction(sender: UISlider) {
    let angle = Int(sender.value * 360)
    print(RYBColorModelAngleToHue.RYBStopToHSVStopMap(angle))
    test()
//    let color = Color(hexString: "FF0000")
//    let newColor = RGBColorWheel.colorAtAngle(color, angle: angle)
//    colorView.backgroundColor = newColor.UIColorValue
//    
//    let wheelAction = ColorWheelAction(colorWheel: RYBColorWheel.self)
//    secondColorView.backgroundColor = wheelAction.complementary(newColor).complementary.UIColorValue
  }
  
  @IBOutlet weak var stackView: UIStackView!
  var colorView: UIView!
  var secondColorView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(Color(hexString: "FF0000").hsb)
    RYBColorModel.angleFromColor(Color.redColor())
    
    print(RYBColorWheel.angleForColor(Color(hexString: "FF7400")))
//
//    addColor(Color(hue: 0, saturation: 0.57, luminosity: 0.45))
//    addColor(Color(hue: 17, saturation: 0.57, luminosity: 0.45))
//    addColor(Color(hue: 27, saturation: 0.57, luminosity: 0.45))
//    
//    let colors = [
//      "712D2D",
//    "712F2D",
//    "71302D",
//    "71322D",
//    "71332D",
//    "71352D",]
    
//    for color in colors {
//      print(Color(hexString: color).hsl)
//    }
    
    let colorsFromRYB = RYBColorModel.DefaultColorsCollection.colors
    var count = 0
    for i in 0..<colorsFromRYB.count {
      let nextIndex = (colorsFromRYB.count - 1 == i) ? 0 : i + 1
      let localColors = ColorGradientTemplate(startColor: colorsFromRYB[i], endColor: colorsFromRYB[nextIndex]).getColorsWithNumberOfSteps(30)
      for color in localColors {
        print("\(count),", color.hsl.hue)
        count += 1
      }
    }
    
    for color in ColorGradientTemplate(startColor: Color(hexString: "F91515"), endColor: Color(hexString: "F97C15")).getColorsWithNumberOfSteps(30) {
      print(color.hexString)
    }
    
    let newColor = Color.redColor()
    let wheelAction = ColorWheelAction(colorWheel: RYBColorWheel.self)
    let colors = wheelAction.rectangle(newColor, secondColorLocation: .Right)
    
    addColor(colors.firstPair.0)
    addColor(colors.firstPair.1)
    
    addColor(colors.secondPair.0)
    addColor(colors.secondPair.1)
    
//    addColor(Color(red: 0.75, yellow: 0.25, blue: 0))
//    addColor(Color(red: 0.5, yellow: 0.5, blue: 0))
//    addColor(Color(red: 0.25, yellow: 0.75, blue: 0))
//    addColor(Color(red: 0, yellow: 1, blue: 0))
//    addColor(Color(red: 0, yellow: 0.75, blue: 0.25))
//    addColor(Color(red: 0, yellow: 0.5, blue: 0.5))
//    addColor(Color(red: 0, yellow: 0.25, blue: 0.75))
//    addColor(Color(red: 0, yellow: 0, blue: 1))
    // Do any additional setup after loading the view.
  }
  
  func test() {
    let newColor = Color.randomColor()
    colorView.backgroundColor = newColor.UIColorValue
    
    let wheelAction = ColorWheelAction(colorWheel: RYBColorWheel.self)
    secondColorView.backgroundColor = wheelAction.splitComplementary(newColor).complementaryLeft
      .UIColorValue
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func addColor(color: Color) {
    let view = UIView()
    view.heightAnchor.constraintEqualToConstant(25).active = true
    view.widthAnchor.constraintEqualToConstant(50).active = true
    view.backgroundColor = color.UIColorValue
    
    if colorView != nil {
      secondColorView = view
    } else {
      colorView = view
    }
    
    stackView.addArrangedSubview(view)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
