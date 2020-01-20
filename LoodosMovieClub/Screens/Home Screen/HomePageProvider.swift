//
//  HomePageProvider.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

protocol HomePageProviderProtocol {
  var networkManager: NetworkManagerProtocol { get }
  var parser: HomeParserProtocol { get }
  func searchForMovie(with title: String, on page: Int)
  func newSearch(with title: String)
  func loadMore()
}

class HomePageProvider: HomePageProviderProtocol {
  weak var viewModel: HomeViewModelProtocol!
  var networkManager: NetworkManagerProtocol
  var parser: HomeParserProtocol
  
  private var pageIndex: Int
  private var searchTerm: String
  private var pageSize: Double
  private var maxPage: Int
  
  init(viewModel: HomeViewModelProtocol, networkManager: NetworkManagerProtocol, parser: HomeParserProtocol) {
    self.viewModel = viewModel
    self.networkManager = networkManager
    self.parser = parser
    pageIndex = 1
    searchTerm = Constants.Strings.emptyString
    pageSize = 10
    maxPage = 1
    print(" |||||| \(String(describing: self)) initialized")
  }
  
  deinit {
    print(" *** \(String(describing: self)) deninitialized")
  }
  
  func newSearch(with title: String) {
    pageIndex = 1
    viewModel.toggleLoadingView?(true)
    searchForMovie(with: title, on: pageIndex)
  }
  
  func searchForMovie(with title: String, on page: Int) {
    networkManager.requestSearch(for: title, on: page) { [weak self] (requestResult) in
      guard let self = self else { return }
      switch requestResult {
      case .success(let movieSearchResponseModel):
        self.viewModel.toggleLoadingView?(false)
        self.calculateMaxPage(for: Double(movieSearchResponseModel.totalResults) ?? 1)
        self.searchTerm = title
        DispatchQueue.global(qos: .userInitiated).async {
          self.viewModel.cellViewModels.append(contentsOf: self.parser.parseSearchedMovies(searchedMovies: movieSearchResponseModel.searchedMovies))
          if self.pageIndex == self.maxPage {
            self.viewModel.cellViewModels.removeLast()
          }
          self.viewModel.dataUpdated?()
        }
      case .failure(let error):
        self.viewModel.toggleLoadingView?(false)
        self.viewModel.showAlert?(error.description)
        printInDebug(error.description, type: .error)
      }
    }
  }
  
  func calculateMaxPage(for totalResults: Double) {
    maxPage = Int(ceil(totalResults / pageSize))
  }
  
  func loadMore() {
    pageIndex += 1
    viewModel.cellViewModels.removeLast()
    searchForMovie(with: searchTerm, on: pageIndex)
  }
}
