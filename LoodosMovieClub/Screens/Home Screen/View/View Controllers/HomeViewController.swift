//
//  HomeViewController.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
  
  // MARK: - Variables
  /// - Public Variables
  
  var manager: HomeManagerProtocol!
  /// - IBOutlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    bindViewModel()
  }
  
  // MARK: - Binding
  private func bindViewModel() {
    manager.viewModel.dataUpdated = reloadData()
    manager.viewModel.showAlert = showAlert()
    manager.viewModel.toggleLoadingView = toggleLoadingView()
    manager.viewModel.showMovieDetail = showMovieDetail()
  }
  
  // MARK: - UI
  private func configureUI() {
    /// Table View
    tableView.dataSource = self
    tableView.delegate = self
    tableView.keyboardDismissMode = .onDrag
    tableView.contentInset = UIEdgeInsets(top: PrivateConstants.tableViewTopInset,
                                          left: PrivateConstants.tableViewLeftInset,
                                          bottom: PrivateConstants.tableViewBottomInset,
                                          right: PrivateConstants.tableViewRightInset)
    
    HomeViewModel.CellType.allCases.forEach { (cellType) in
      tableView.register(UINib(nibName: cellType.identifier, bundle: nil), forCellReuseIdentifier: cellType.identifier)
    }
    
    /// Search Bar
    searchBar.delegate = self
  }
}

extension HomeViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    manager.viewModel.showDetail(for: indexPath)
  }
  
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

extension HomeViewController {
  func reloadData() -> VoidHandler {
    return { [weak self] in
      DispatchQueue.main.async {
        guard let self = self else { return }
        self.loadingView.dismiss()
        self.tableView.reloadData()
      }
    }
  }
  
  func showAlert() -> (String) -> Void {
    return { [weak self] alertMessage in
      DispatchQueue.main.async {
        guard let self = self else { return }
        let alertVC = UIAlertController(title: Constants.Strings.alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constants.Strings.alertActionTitle, style: .default)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
      }
    }
  }
  
  func showMovieDetail() -> (String) -> Void {
    return { [weak self] imdbID in
      guard let self = self else { return }
      DispatchQueue.main.async {
        let viewController = ViewControllerMaker.detailViewController(for: imdbID)
        self.show(viewController, sender: nil)
      }
    }
  }
}

extension HomeViewController {
  struct PrivateConstants {
    static let tableViewTopInset: CGFloat = 50
    static let tableViewLeftInset: CGFloat = 0
    static let tableViewBottomInset: CGFloat = 50
    static let tableViewRightInset: CGFloat = 0
  }
}
