//
//  FontInfoViewController.swift
//  Fonts
//
//  Created by Victor Smirnov on 04/12/2017.
//  Copyright © 2017 Victor Smirnov. All rights reserved.
//

import UIKit

class FontInfoViewController: UIViewController {
  
  var font: UIFont!
  var favorite = false
  
  @IBOutlet weak var fontSampleLabel: UILabel!
  @IBOutlet weak var fontSizeSlider: UISlider!
  @IBOutlet weak var fontSizeLabel: UILabel!
  @IBOutlet weak var favoriteSwitch: UISwitch!
  
  @IBAction func slideFontSize(_ sender: UISlider) {
    let newSize = roundf(sender.value)
    fontSampleLabel.font = font.withSize(CGFloat(newSize))
    fontSizeLabel.text = "\(newSize)"
  }
  
  @IBAction func toggleFavorite(_ sender: UISwitch) {
    let favoriteList = FavoritesList.sharedFavoriteList
    if sender.isOn {
      favoriteList.addFavorite(fontName: font.fontName)
    } else {
      favoriteList.removeFavorites(fontName: font.fontName)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fontSampleLabel.font = font
    fontSampleLabel.text = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz 0123456789"
    favoriteSwitch.isOn = favorite
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
