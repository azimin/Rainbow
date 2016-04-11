//
//  ColorsOnImageGenerateTableViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 10/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class ColorsOnImageGenerateTableViewController: UITableViewController {
  
  @IBOutlet weak var numberOfColorsLabel: UILabel!
  var delegate: ColorsOnImageGenerateDelegate?
  
  @IBOutlet weak var stepper: UIStepper!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func stepperAction(sender: UIStepper) {
    numberOfColorsLabel.text = "Number of colors: \(Int(sender.value))"
  }
  
  @IBAction func generateColorsOnImageButtonAction(sender: AnyObject) {
    delegate?.colorsOnImageGenerateWithSelectedSettings(ColorsOnImageGenerateSettings(numberOfColors: Int(stepper.value), comressionType: segmentedControl.selectedSegmentIndex))
    TAWindowShower.sharedInstance.closeTopWindow()
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == 2 {
      generateColorsOnImageButtonAction(tableView)
    }
  }
}
