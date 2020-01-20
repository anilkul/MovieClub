//
//  HomeViewController.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
  
  var manager: HomeManagerProtocol!
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  
  
  override func viewDidLoad() {
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
    tableView.register(UINib(nibName:"MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    tableView.register(UINib(nibName:"MoviePlaceholderCell", bundle: nil), forCellReuseIdentifier: "MoviePlaceholderCell")
    manager.viewModel.dataUpdated = reloadData()
    manager.viewModel.showAlert = showAlert()
    manager.viewModel.toggleLoadingView = toggleLoadingView()
    super.viewDidLoad()
  }
  
  func reloadData() -> VoidHandler {
    return { [weak self] in
      DispatchQueue.main.async {
        guard let self = self else { return }
        self.tableView.reloadData()
      }
    }
  }
  
  func showAlert() -> (String) -> Void {
    return { [weak self] alertMessage in
      DispatchQueue.main.async {
        guard let self = self else { return }
        let alertVC = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
      }
    }
  }
}

extension HomeViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    manager.viewModel.searchForMovie(with: searchBar.text)
  }
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return manager.viewModel.cellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellViewModel = manager.viewModel.cellViewModel(for: indexPath)
    
    let identifier = cellViewModel.cellType.identifier
    guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? BaseCell else {
      fatalError("Movie Cell could not be created")
    }
    cell.pageProvider = manager.pageProvider
    cell.configureCell(with: cellViewModel, for: indexPath)
    return cell
  }
}

extension HomeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellViewModel = manager.viewModel.cellViewModel(for: indexPath)
    return cellViewModel.getEstimatedHeight()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellViewModel = manager.viewModel.cellViewModel(for: indexPath)
    return cellViewModel.getCellHeight()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let cell = cell as? BaseCell
    cell?.willDisplay()
  }
  
}
