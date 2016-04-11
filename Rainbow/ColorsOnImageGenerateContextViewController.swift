//
//  ColorsOnImageGenerateContextViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 10/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

struct ColorsOnImageGenerateSettings {
  var numberOfColors: Int
  var comressionType: Int
}

protocol ColorsOnImageGenerateDelegate {
  func colorsOnImageGenerateWithSelectedSettings(setting: ColorsOnImageGenerateSettings)
}

class ColorsOnImageGenerateContextViewController: UIViewController {
  
  @IBOutlet weak var containerView: UIView!
  weak var remindViewController: ColorsOnImageGenerateTableViewController?
  var delegate: ColorsOnImageGenerateDelegate? {
    didSet {
      remindViewController?.delegate = delegate
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    containerView.layer.cornerRadius = 8
    containerView.layer.masksToBounds = true
    // Do any additional setup after loading the view.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    remindViewController = segue.destinationViewController as? ColorsOnImageGenerateTableViewController
    remindViewController?.delegate = delegate
  }
  
  
}
