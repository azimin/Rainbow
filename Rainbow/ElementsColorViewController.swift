//
//  ElementsColorViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 14/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class ElementsColorViewController: UIViewController {
  
  var color: Color = .whiteColor()
  
  @IBOutlet var controls: [UIControl]!
  
  @IBOutlet weak var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = color.UIColorValue
    label.textColor = color.contrastingBlackOrWhite().UIColorValue
    
    loadContrastColor()
  }
  
  func loadContrastColor() {    
    for control in controls {
      let elementsColor = color.contrastRandomColor().UIColorValue
      if let segmentedControl = control as? UISegmentedControl {
        segmentedControl.tintColor = elementsColor
      }
      
      if let button = control as? UIButton {
        button.setTitleColor(elementsColor, forState: .Normal)
      }
    }
  }
  
  @IBAction func refreshAction(sender: UIBarButtonItem) {
    loadContrastColor()
  }
}
