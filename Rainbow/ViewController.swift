//
//  ViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var baseColorView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let redColor = UIColor.redColor()
    let color = Color(color: redColor)
    
    let image = UIImage(named: "4db0324ff3")!.CGImage!
    
    var colors = ColorOnImage.dominantColorsInImage(image, maxSampledPixels: 1000, accuracy: GroupingAccuracy.High, seed: 100, memoizeConversions: false)
    
    for i in 0..<5 {
      addColor(colors[i])
    }
    
    print(Color(color: baseColorView.backgroundColor)?.RGBValue)
    print(color.RGBValue)
    print(LABColor(color: color))
    
    
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func addColor(color: Color) {
    let view = UIView()
    view.heightAnchor.constraintEqualToConstant(50).active = true
    view.widthAnchor.constraintEqualToConstant(50).active = true
    
    view.backgroundColor = color.UIColorValue
    
    stackView.addArrangedSubview(view)
  }


}

