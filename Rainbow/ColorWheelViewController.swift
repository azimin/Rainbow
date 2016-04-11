//
//  ColorWheelViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 11/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class ColorWheelViewController: UIViewController {
  
  @IBOutlet weak var wheelImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    wheelImageView.image = ColorWheelImageDrawer.drawImage(CGSize(width: 240, height: 240), colorWheel: RGBColorWheel.self)
    // Do any additional setup after loading the view.
  }
  
  
  @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
    let type: ColorWheelType.Type = sender.selectedSegmentIndex == 0 ? RGBColorWheel.self : RYBColorWheel.self
    wheelImageView.image = ColorWheelImageDrawer.drawImage(CGSize(width: 260, height: 260), colorWheel: type)
  }
  
}
