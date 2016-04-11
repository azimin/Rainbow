//
//  ViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 18/01/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

class ColorFromImageViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func openImageAction(sender: AnyObject) {
    let picker = UIImagePickerController()
    picker.delegate = self
    self.presentViewController(picker, animated: true, completion: nil)
  }
  
  @IBAction func generateAction(sender: AnyObject) {
    let colorsOnImageGenerateContext = UIStoryboard(name: "ColorsOnImageGenerate", bundle: nil).instantiateInitialViewController() as! ColorsOnImageGenerateContextViewController
    colorsOnImageGenerateContext.delegate = self
    TAWindowShower.sharedInstance.presentViewController(colorsOnImageGenerateContext, animationDataSource: nil)
  }
  
}

extension ColorFromImageViewController: ColorsOnImageGenerateDelegate {
  func colorsOnImageGenerateWithSelectedSettings(setting: ColorsOnImageGenerateSettings) {
    let colors = ColorOnImage.dominantColorsInImage(imageView.image!.CGImage!, numberOfGeneratedColols: setting.numberOfColors, maxSampledPixels: 2000, accuracy: GroupingAccuracy(rawValue: setting.comressionType)!, seed: 100)
    
    let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ColorsCollectionViewController") as! ColorsCollectionViewController
    viewController.colors = colors
    
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

extension ColorFromImageViewController: UIImagePickerControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    imageView.image = image
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}

extension ColorFromImageViewController: UINavigationControllerDelegate {
  
}
