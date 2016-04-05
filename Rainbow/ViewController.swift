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
    let color = Color(hexString: "FF0000")
    colorView.backgroundColor = RGBColorWheel.colorAtAngle(color, angle: angle).UIColorValue
  }
  
  @IBOutlet weak var stackView: UIStackView!
  var colorView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(Color(hexString: "FF0000").hsb)
    
//    addColor(Color(hexString: "15858F"))
//    addColor(Color(hexString: "53A9B1"))
//    addColor(Color(hexString: "308E97"))
//    addColor(Color(hexString: "086A73"))
//    addColor(Color(hexString: "01545B"))

    let angle = -40
    let colro = RYBColorWheel.colorAtAngle(angle)
    addColor(colro)
    
    
    
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
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func addColor(color: Color) {
    let view = UIView()
    view.heightAnchor.constraintEqualToConstant(25).active = true
    view.widthAnchor.constraintEqualToConstant(50).active = true
    view.backgroundColor = color.UIColorValue
    
    colorView = view
    
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
