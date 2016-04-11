//
//  CurrentColorTableViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 11/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class CurrentColorTableViewController: UITableViewController {
  
  var isDefined = false
  var color: Color = colorInClipboard {
    didSet {
      if isViewLoaded() {
        updateValue()
      } else {
        isDefined = true
      }
    }
  }
  
  @IBOutlet weak var colorView: UIView!
  
  // Color labels
  @IBOutlet weak var nameColorLabel: UILabel!
  @IBOutlet weak var hexColorLabel: UILabel!
  @IBOutlet weak var rgbColorLabel: UILabel!
  @IBOutlet weak var labColorLabel: UILabel!
  @IBOutlet weak var hsbColorLabel: UILabel!
  @IBOutlet weak var hslColorLabel: UILabel!
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return isDefined ? 2 : 3
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    colorView.layer.borderWidth = 1
    colorView.layer.borderColor = Color.lightGreyColor().CGColorValue
    colorView.layer.cornerRadius = colorView.frame.width / 2
    
    updateValue()
  }
  
  func updateValue() {
    colorView.backgroundColor = color.UIColorValue
    
    labelTitle(nameColorLabel, prefixString: "NAME:", sufixString: color.name)
    labelTitle(hexColorLabel, prefixString: "HEX:", sufixString: color.hexString)
    labelTitle(rgbColorLabel, prefixString: "RGB:", sufixString: converToString(color.RGBVector.toFloatTuple()))
    labelTitle(labColorLabel, prefixString: "LAB:", sufixString: converToString(color.lab))
    labelTitle(hsbColorLabel, prefixString: "HSB:", sufixString: converToString(color.hsb))
    labelTitle(hslColorLabel, prefixString: "HSL:", sufixString: converToString(color.hsl))
    
    let shouldUseBorder = color.shouldUseBorder(Color.whiteColor())
    colorView.layer.borderWidth = shouldUseBorder ? 1 : 0
  }
  
  func labelTitle(label: UILabel, prefixString: String, sufixString: String) {
    let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(16)]
    let boldString = NSMutableAttributedString(string: prefixString + " " + sufixString)
    boldString.addAttributes(attrs, range: NSRange(location: 0, length: prefixString.characters.count))
    label.attributedText = boldString
  }
  
  func converToString(tupple: (Float, Float, Float)) -> String {
    let first = String(format: "%.2f", tupple.0)
    let second = String(format: "%.2f", tupple.1)
    let third = String(format: "%.2f", tupple.2)
    return "(\(first), \(second), \(third))"
  }
  
  func converToString(tupple: (Int, Float, Float)) -> String {
    let second = String(format: "%.2f", tupple.1)
    let third = String(format: "%.2f", tupple.2)
    return "(\(tupple.0), \(second), \(third))"
  }
  
  // MARK: - Table view data source
  
  @IBAction func randomColorGenerateAction(sender: UIButton) {
    color = Color.randomColor()
  }
  
  @IBAction func setHEXButtonAction(sender: UIButton) {
    let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
    
    let setAction = UIAlertAction(title: "Set", style: .Default) { (_) in
      let loginTextField = alertController.textFields![0] as UITextField
      let hexString = loginTextField.text ?? "000000"
      self.color = Color(hexString: hexString)
    }
    setAction.enabled = false
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
    
    alertController.addTextFieldWithConfigurationHandler { (textField) in
      textField.placeholder = "HEX string"
      
      NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
        setAction.enabled = Color.isHexString(textField.text ?? "")
      }
    }
    
    alertController.addAction(setAction)
    alertController.addAction(cancelAction)
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  @IBAction func saveToClipboardAction(sender: AnyObject) {
    colorInClipboard = color
  }
}
