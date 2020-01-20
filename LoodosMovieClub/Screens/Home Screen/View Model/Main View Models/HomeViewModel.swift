//
//  HomeViewModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
  var pageProvider: HomePageProviderProtocol? { get set }
  var cellViewModels: [SearchListCellViewModelProtocol] { get set }
  var dataUpdated: VoidHandler? { get set }
  var showAlert: ((_ alertMessage: String) -> Void)? { get set }
  var toggleLoadingView: ((_ isActive: Bool) -> Void)? { get set }
  
  func cellViewModel(for indexPath: IndexPath) -> SearchListCellViewModelProtocol
  func searchForMovie(with title: String?)
}

class HomeViewModel: HomeViewModelProtocol {
  var toggleLoadingView: ((Bool) -> Void)?
  
  var pageProvider: HomePageProviderProtocol?
  var cellViewModels: [SearchListCellViewModelProtocol]
  var dataUpdated: VoidHandler?
  var showAlert: ((String) -> Void)?
  
  init() {
    cellViewModels = []
    print(" |||||| \(String(describing: self)) initialized")
  }
  
  deinit {
    print(" *** \(String(describing: self)) deninitialized")
  }
  
  func searchForMovie(with title: String?) {
    cellViewModels.removeAll()
    guard let searchTerm = title else { return }
    pageProvider?.newSearch(with: searchTerm)
  }
  
  func cellViewModel(for indexPath: IndexPath) -> SearchListCellViewModelProtocol {
    return cellViewModels[safe: indexPath.row] ?? SearchListCellViewModel()
  }
}
