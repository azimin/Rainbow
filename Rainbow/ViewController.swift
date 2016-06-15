//
//  ViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 05/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

struct Person {
  var firstName: String
  var secondName: String
}

struct PersonModel {
  var person: Person
  var name: String {
    return "\(person.firstName) \(person.secondName)"
  }
}

class ViewController: UIViewController {
  
  var personModel: PersonModel!
  @IBOutlet var nameLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameLabel.text = personModel.name
    
    let color = Color.redColor()
    
    color << Message.getSuchColor(.Red)
    color << Message.effect.NotVeryContrast
  }
  
  
  @IBAction func sliderAction(sender: UISlider) {
    //let angle = Int(sender.value * 360)
    

    let color = RGBColorWheel.colorAtAngle(60)
    print(color)
    
    colorView.backgroundColor = color.UIColorValue
    
    
    let suchRed = color << Message.getSuchColor(.Red)
    let contrastColor = color << Message.effect.NotVeryContrast
    secondColorView.backgroundColor = contrastColor.UIColorValue

    Color(hexString: "99B86F") << Message.getSuchColor(.Red)
    
  }
  
  func colorTake(color: UIColor) {
    
  }
  
  @IBOutlet weak var stackView: UIStackView!
  var colorView: UIView!
  var secondColorView: UIView!
  
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
