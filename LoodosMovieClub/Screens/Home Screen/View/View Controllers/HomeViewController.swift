//
//  HomeViewController.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
  
  var manager: HomeManagerProtocol!
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//      self.dismiss(animated: true)
//    }
  }
}
