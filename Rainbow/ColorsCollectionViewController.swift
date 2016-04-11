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
    
    cell.colorView.backgroundColor = colors[indexPath.row].UIColorValue
    cell.colorNameLabel.text = colors[indexPath.row].hexString
    
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
  }
}

extension ColorsCollectionViewController: UITableViewDelegate {
  
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
    
    // Do any additional setup after loading the view.
  }
  
}
