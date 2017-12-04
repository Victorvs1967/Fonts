//
//  FontListViewController.swift
//  Fonts
//
//  Created by Victor Smirnov on 04/12/2017.
//  Copyright © 2017 Victor Smirnov. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
  
  var fontNames: [String] = []
  var showsFavorites = false
  private var cellPointSize: CGFloat!
  private static let cellIdentifier = "FontName"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let prefferedTableViewFont = UIFont.preferredFont(forTextStyle: .headline)
    cellPointSize = prefferedTableViewFont.pointSize
    tableView.estimatedRowHeight = cellPointSize
    
    if showsFavorites{
      navigationItem.rightBarButtonItem = editButtonItem
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if showsFavorites {
      fontNames = FavoritesList.sharedFavoriteList.favorites
      tableView.reloadData()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func fontForDisplay(atIndexPath indexPath: IndexPath) -> UIFont {
    let fontName = fontNames[indexPath.row]
    return UIFont(name: fontName, size: cellPointSize)!
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return fontNames.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FontListViewController.cellIdentifier, for: indexPath)
    cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
    cell.textLabel?.text = fontNames[indexPath.row]
    cell.detailTextLabel?.text = fontNames[indexPath.row]
    return cell
  }
  
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return showsFavorites
  }
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if !showsFavorites {
      return
    }
    if editingStyle == .delete {
      // Delete the row from the data source
      let favorite = fontNames[indexPath.row]
      FavoritesList.sharedFavoriteList.removeFavorites(fontName: favorite)
      fontNames = FavoritesList.sharedFavoriteList.favorites
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }
  
  // Override to support rearranging the table view.
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    FavoritesList.sharedFavoriteList.moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
    fontNames = FavoritesList.sharedFavoriteList.favorites
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    let tableViewCell = sender as! UITableViewCell
    let indexPath = tableView.indexPath(for: tableViewCell)!
    let font = fontForDisplay(atIndexPath: indexPath)
    
    if segue.identifier == "ShowFontSizes" {
      let sizesVC = segue.destination as! FontSizesViewController
      sizesVC.title = font.fontName
      sizesVC.font = font
    } else {
      let infoVC = segue.destination as! FontInfoViewController
      infoVC.title = font.fontName
      infoVC.font = font
      infoVC.favorite = FavoritesList.sharedFavoriteList.favorites.contains(font.fontName)
    }
    
  }
  
}
