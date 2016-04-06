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
    //let angle = Int(sender.value * 360)
    
    let color = Color.randomColor()
    
    colorView.backgroundColor = color.UIColorValue
    
    
//    let contrastColor = color << Message.getSuchColor(.Red)
    let contrastColor = color << Message.effect.NotVeryContrast
    secondColorView.backgroundColor = contrastColor.UIColorValue

  }
  
  func colorTake(color: UIColor) {
    
  }
  
  @IBOutlet weak var stackView: UIStackView!
  var colorView: UIView!
  var secondColorView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    let newColor = Color.redColor()
//    let wheelAction = ColorWheelAction(colorWheel: RYBColorWheel.self)
//    let colors = wheelAction.rectangle(newColor, movementAngle: 30)
//    
//    addColor(colors.firstPair.0)
//    addColor(colors.firstPair.1)
//    
//    addColor(colors.secondPair.0)
//    addColor(colors.secondPair.1)
    
    addColor(ColorWheelAction().complementary(Color(hexString: "F3A254")).original)
    addColor(ColorWheelAction().complementary(Color(hexString: "F3A254")).complementary)
    
    print(Color(hexString: "7109AA").RGBVector)
    
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
    secondColorView.backgroundColor = wheelAction.splitComplementary(newColor).complementaryLeft.UIColorValue
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
