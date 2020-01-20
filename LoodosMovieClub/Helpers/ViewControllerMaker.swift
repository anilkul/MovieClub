//
//  ViewControllerMaker.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

class ViewControllerMaker {
  
  enum Identifier: String {
    case home = "HomeViewController",
    detail = "DetailViewController"
  }
  
  @discardableResult
  static func defineViewController<T: UIViewController>(with identifier: String,
                                                        of type: T.Type? = nil) -> T {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("Could not define view controller with identifier: \(identifier), from storyboard: Main")
    }
    return viewController
  }
  
  static func homeViewController() -> HomeViewController {
    guard let viewController = defineViewController(with: Identifier.home.rawValue) as? HomeViewController else { return HomeViewController() }
    viewController.manager = HomeManager()
    return viewController
  }
}
