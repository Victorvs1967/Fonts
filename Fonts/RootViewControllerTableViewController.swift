//
//  RootViewControllerTableViewController.swift
//  Fonts
//
//  Created by Victor Smirnov on 03/12/2017.
//  Copyright © 2017 Victor Smirnov. All rights reserved.
//

import UIKit

class RootViewControllerTableViewController: UITableViewController {
  
  private var familyNames: [String]!
  private var cellPointSize: CGFloat!
  private var favoritesList: FavoritesList!
  private static let familyCell = "FamilyName"
  private static let favoritesCell = "Favorites"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    FamilyName = (UIFont.familyNames() as [String]).sorted()
    let prefferedTableViewFont = UIFont.prefferedTableViewFont(forTextStyle: UIFontTextStyleHeadline)
    cellPointSize = prefferedTableViewFont.pointSize
    favoritesList = FavoritesList.sharedFavoritesList
    tableView.estimatedRowHeight = cellPointSize
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func fontForDispley(atIndecPath indexPath: IndexPath) -> UIFont? {
    if indexPath.section == 0 {
      let familyName = familyNames[indexPath.row]
      let fontName = UIFont.fontNames(forFamilyName: familyName).first
      return fontName != nil ? UIFont(name: fontName!, size: cellPointSize) : nil
    } else {
      return nil
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return favoritesList.favorites.isEmpty ? 1 : 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return section == 0 ? familyNames.count : 1
  }
  
  /*
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
   
   // Configure the cell...
   
   return cell
   }
   */
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
