//
//  DetailViewController.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 20.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var ratedLabel: UIImageView!
  @IBOutlet weak var typeLabel: UIImageView!
  
  @IBOutlet weak var imdbLabel: UILabel!
  @IBOutlet weak var rottenTomatoesLabel: UILabel!
  @IBOutlet weak var metacriticLabel: UILabel!
  
  @IBOutlet weak var plotLabel: UILabel!
  @IBOutlet weak var directorLabel: UILabel!
  @IBOutlet weak var writerLabel: UILabel!
  @IBOutlet weak var actorsLabel: UILabel!
  
  var viewModel: DetailViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func closeButtonTapped(_ sender: Any) {
    self.dismiss(animated: true)
  }
}
