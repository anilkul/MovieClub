//
//  HomeViewModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
  /// - Public Variables
  var cellViewModels: [SearchListCellViewModelProtocol] { get set }
  var pageProvider: HomePageProviderProtocol? { get set }
  
  /// - Closures
  var showAlert: ((_ alertMessage: String) -> Void)? { get set }
  var toggleLoadingView: ((_ isActive: Bool) -> Void)? { get set }
  var showMovieDetail: ((_ imdbID: String) -> Void)? { get set }
  var dataUpdated: VoidHandler? { get set }
  
  /// - Functions
  func cellViewModel(for indexPath: IndexPath) -> SearchListCellViewModelProtocol
  func searchForMovie(with title: String?)
  func showDetail(for indexPath: IndexPath)
}

class HomeViewModel: HomeViewModelProtocol {
  // MARK: - Variables
  /// - Public Variables
  var pageProvider: HomePageProviderProtocol?
  var cellViewModels: [SearchListCellViewModelProtocol]
  
  /// - Closures
  var showMovieDetail: ((String) -> Void)?
  var toggleLoadingView: BoolHandler?
  var dataUpdated: VoidHandler?
  var showAlert: ((String) -> Void)?
  
  init() {
    cellViewModels = []
  }
  
  func searchForMovie(with title: String?) {
    cellViewModels.removeAll()
    guard let searchTerm = title else { return }
    pageProvider?.newSearch(with: searchTerm)
  }
  
  func cellViewModel(for indexPath: IndexPath) -> SearchListCellViewModelProtocol {
    return cellViewModels[safe: indexPath.row] ?? SearchListCellViewModel()
  }
  
  // MARK: - Navigation
  func showDetail(for indexPath: IndexPath) {
    guard let selectedCellViewModel = cellViewModel(for: indexPath) as? MovieCellViewModelProtocol else { return }
    showMovieDetail?(selectedCellViewModel.imdbID)
  }
}
