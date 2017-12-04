//
//  FavoriteList.swift
//  Fonts
//
//  Created by Victor Smirnov on 03/12/2017.
//  Copyright © 2017 Victor Smirnov. All rights reserved.
//

import UIKit
import Foundation

class FavoritesList: NSObject {
  static let sharedFavoriteList = FavoritesList()
  private (set) var favorites: [String]
  
  override init() {
    let defaults = UserDefaults.standard
    let storedFavorites = defaults.object(forKey: "favorites") as? [String]
    favorites = storedFavorites != nil ? storedFavorites! : []
  }
  
  func addFavorite(fontName: String) {
    if favorites.contains(fontName) {
      favorites.append(fontName)
      saveFavorites()
    }
  }
  func removeFavorites(fontName: String) {
    if let index = favorites.index(of: fontName) {
      favorites.remove(at: index)
      saveFavorites()
    }
  }
  func saveFavorites() {
    let defaults = UserDefaults.standard
    defaults.set(favorites, forKey: "favorites")
    defaults.synchronize()
  }
  
}
