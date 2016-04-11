//
//  ColorsCollectionViewController.swift
//  Rainbow
//
//  Created by Alex Zimin on 07/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

extension ColorsCollectionViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return colors.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ColorTableViewCell
    
    cell.color = colors[indexPath.row]
    
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
  }
}

extension ColorsCollectionViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    self.performSegueWithIdentifier("ColorPreview", sender: indexPath)
  }
}

class ColorsCollectionViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var colors: [Color] = [] {
    didSet {
      tableView?.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for i in 0..<1000 {
      colors.append(Color.randomColor())
    }
    // Do any additional setup after loading the view.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let indexPath = sender as! NSIndexPath
    let currentColorViewController = segue.destinationViewController as! CurrentColorTableViewController
    currentColorViewController.color = colors[indexPath.row]
  }
}
