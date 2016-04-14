//
//  ActionsWithColorTableViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 13/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class ActionsWithColorTableViewController: UITableViewController {
  
  var color: Color = Color.whiteColor()
  
  @IBOutlet weak var recomendedColorView: UIView!
  @IBOutlet weak var balancedColorView: UIView!
  @IBOutlet weak var colorView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    colorView.layer.cornerRadius = recomendedColorView.frame.width / 2
    recomendedColorView.layer.cornerRadius = recomendedColorView.frame.width / 2
    balancedColorView.layer.cornerRadius = balancedColorView.frame.width / 2
    
    recomendedColorView.layer.borderColor = Color(hexString: "868686").CGColorValue
    colorView.layer.borderColor = Color(hexString: "868686").CGColorValue
    balancedColorView.layer.borderColor = Color(hexString: "868686").CGColorValue
    
    colorView.backgroundColor = color.UIColorValue
    recomendedColorView.backgroundColor = (color << Message.whiteOrBlackContrast).UIColorValue
    balancedColorView.backgroundColor = color.minimalColor().UIColorValue
    
    var shouldUseBorder = recomendedColorView.backgroundColor!.color.shouldUseBorder(Color.whiteColor())
    recomendedColorView.layer.borderWidth = shouldUseBorder ? 1 : 0
    
    shouldUseBorder = colorView.backgroundColor!.color.shouldUseBorder(Color.whiteColor())
    colorView.layer.borderWidth = shouldUseBorder ? 1 : 0
    
    shouldUseBorder = balancedColorView.backgroundColor!.color.shouldUseBorder(Color.whiteColor())
    balancedColorView.layer.borderWidth = shouldUseBorder ? 1 : 0
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let colorsViewController = segue.destinationViewController as? ColorsCollectionViewController {
      colorsViewController.colors = color << Message.getSuchColors()
    }
    
    if let elementsColorVC = segue.destinationViewController as? ElementsColorViewController {
      elementsColorVC.color = color
    }
    
    if let backgroundColorVC = segue.destinationViewController as? BackgroundsColorViewController {
      backgroundColorVC.color = color
    }
  }
  
}
