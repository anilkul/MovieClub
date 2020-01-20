//
//  DetailViewController.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 20.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var viewModel: DetailViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func closeButtonTapped(_ sender: Any) {
    self.dismiss(animated: true)
  }
}
