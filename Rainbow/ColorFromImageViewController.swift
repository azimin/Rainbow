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
  @IBOutlet weak var stackView: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    makeImage(UIImage(named: "4db0324ff3")!)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func makeImage(image: UIImage) {
    var colors = ColorOnImage.dominantColorsInImage(image.CGImage!, maxSampledPixels: 2000, accuracy: GroupingAccuracy.High, seed: 100)
    print(colors.count)
    
    _ = stackView.arrangedSubviews.map() {  $0.removeFromSuperview() }
    for i in 0..<6 {
      addColor(colors[i])
    }
  }
  
  func addColor(color: Color) {
    let view = UIView()
    view.heightAnchor.constraintEqualToConstant(25).active = true
    view.widthAnchor.constraintEqualToConstant(50).active = true
    
    let label = UILabel()
    label.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
    label.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
    label.textAlignment = .Center
    label.text = color.RGBValue.rawValue
    label.textColor = UIColor.blackColor()
    
    view.backgroundColor = color.UIColorValue
    
    stackView.addArrangedSubview(view)
    stackView.addArrangedSubview(label)
  }

  @IBAction func openImageAction(sender: AnyObject) {
    let picker = UIImagePickerController()
    picker.delegate = self
    self.presentViewController(picker, animated: true, completion: nil)
  }
  
}

extension ColorFromImageViewController: UIImagePickerControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    makeImage(image)
    imageView.image = image
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}

extension ColorFromImageViewController: UINavigationControllerDelegate {
  
}
