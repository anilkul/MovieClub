//
//  SplashViewController.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
  
  // MARK: - Variables
  
  /// - IBOutlets
  @IBOutlet weak var companyNameLabel: UILabel!
  @IBOutlet weak var noConnectionStackView: UIStackView!
  
  /// - Private Variables
  private var viewModel: SplashViewModelProtocol!

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = SplashViewModel()
    configureUI()
    goToHomeScreenIfPossible()
  }
  
  // MARK: - Configuration
  private func configureUI() {
    companyNameLabel.text = Constants.Strings.companyName
  }
  
  // MARK: - Navigation
  private func goToHomeScreenIfPossible() {
    guard viewModel.hasConnection else {
      showAlert()
      return
    }
    goToHomeScreen()
  }
  
  private func goToHomeScreen() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.performSegue(withIdentifier: "goToHomeScreen", sender: nil)
    }
  }
  
  private func showAlert() {
    let alertVC = UIAlertController(title: "Bağlantı Yok!", message: "Devam edebilmek için lütfen internet bağlantınız olduğundan emin olun", preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Tamam", style: .default) { _ in
      self.noConnectionStackView.isHidden = false
    }
    alertVC.addAction(alertAction)
    DispatchQueue.main.async {
      self.present(alertVC, animated: true, completion: nil)
    }
  }
}


