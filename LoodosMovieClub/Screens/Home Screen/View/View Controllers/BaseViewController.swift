//
//  BaseViewController.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 20.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit
import JGProgressHUD

class BaseViewController: UIViewController {
  
  var loadingView: JGProgressHUD!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadingView = JGProgressHUD(style: .dark)
    loadingView.textLabel.text = Constants.Strings.loadingText
  }
  
  func toggleLoadingView() -> BoolHandler {
    return { [weak self] isActive in
      guard let self = self else { return }
      DispatchQueue.main.async {
        isActive ? self.loadingView.show(in: self.view) : self.loadingView.dismiss()
      }
    }
  }
  
}
