//
//  RootViewController.swift
//  Fonts
//
//  Created by Victor Smirnov on 03/12/2017.
//  Copyright © 2017 Victor Smirnov. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
  
  private var familyNames: [String]!
  private var cellPointSize: CGFloat!
  private var favoritesList: FavoritesList!
  private static let familyCell = "FamilyName"
  private static let favoritesCell = "Favorites"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    familyNames = (UIFont.familyNames as [String]).sorted()
    favoritesList = FavoritesList.sharedFavoriteList
    
    let prefferedTableViewFont = UIFont.preferredFont(forTextStyle: .headline)
    cellPointSize = prefferedTableViewFont.pointSize
    tableView.estimatedRowHeight = cellPointSize
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func fontForDisplay(atIndecPath indexPath: IndexPath) -> UIFont? {
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
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return section == 0 ? "All Fonts Families" : "My Favorite Fonts"
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: RootViewController.familyCell, for: indexPath)
      cell.textLabel?.font = fontForDisplay(atIndecPath: indexPath)
      cell.textLabel?.text = familyNames[indexPath.row]
      cell.detailTextLabel?.text = familyNames[indexPath.row]
      return cell
    } else {
      return tableView.dequeueReusableCell(withIdentifier: RootViewController.favoritesCell, for: indexPath)
    }
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
    let listVC = segue.destination as! FontListViewController
    
    if indexPath.section == 0 {
      let familyName = familyNames[indexPath.row]
      listVC.fontNames = (UIFont.fontNames(forFamilyName: familyName) as [String]).sorted()
      listVC.navigationItem.title = familyName
      listVC.showsFavorites = false
    } else {
      listVC.fontNames = favoritesList.favorites
      listVC.navigationItem.title = "Favorites"
      listVC.showsFavorites = true
    }
  }
  
}
