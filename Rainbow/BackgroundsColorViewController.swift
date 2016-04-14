//
//  BackgroundsColorViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 14/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class BackgroundsColorViewController: UIViewController {
  
  var color: Color = Color.whiteColor()
  
  @IBOutlet var backgroudnViews: [UIView]!
  @IBOutlet var textLabels: [UILabel]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    for label in textLabels {
      label.textColor = color.UIColorValue
    }
    updateBG()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func refreshButtonAction(sender: UIBarButtonItem) {
    updateBG()
  }
  
  func updateBG() {
    for backgrouundView in backgroudnViews {
      backgrouundView.backgroundColor = color.contrastRandomColor().UIColorValue
    }
  }
  
}
