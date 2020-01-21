//
//  HomePageProvider.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

protocol HomePageProviderProtocol {
  /// - Variables
  var networkManager: NetworkManagerProtocol { get }
  var parser: HomeParserProtocol { get }
  
  /// - Functions
  func searchForMovie(with title: String, on page: Int)
  func newSearch(with title: String)
  func loadMore()
}

class HomePageProvider: HomePageProviderProtocol {
  // MARK: - Variables
  /// - Public Variables
  weak var viewModel: HomeViewModelProtocol!
  var networkManager: NetworkManagerProtocol
  var parser: HomeParserProtocol
  
  /// - Private Variables
  private var pageIndex: Int
  private var searchTerm: String
  private var pageSize: Double
  private var maxPage: Int
  
  init(viewModel: HomeViewModelProtocol, networkManager: NetworkManagerProtocol, parser: HomeParserProtocol) {
    self.viewModel = viewModel
    self.networkManager = networkManager
    self.parser = parser
    pageIndex = PrivateConstants.pageIndexInitialValue
    searchTerm = Constants.Strings.emptyString
    pageSize = PrivateConstants.defaultPageSize
    maxPage = PrivateConstants.maxPageInitialValue
  }
  
  func newSearch(with title: String) {
    pageIndex = PrivateConstants.pageIndexInitialValue
    viewModel.toggleLoadingView?(true)
    searchForMovie(with: title, on: pageIndex)
  }
  
  func searchForMovie(with title: String, on page: Int) {
    networkManager.requestSearch(for: title, on: page) { [weak self] (requestResult) in
      guard let self = self else { return }
      switch requestResult {
      case .success(let movieSearchResponseModel):
        self.calculateMaxPage(for: Double(movieSearchResponseModel.totalResults) ?? Double(PrivateConstants.maxPageInitialValue))
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
  
  func loadMore() {
    pageIndex += PrivateConstants.pageIndexIncrementalValue
    viewModel.cellViewModels.removeLast()
    searchForMovie(with: searchTerm, on: pageIndex)
  }
  
  // MARK: - Helper Functions
  func calculateMaxPage(for totalResults: Double) {
    maxPage = Int(ceil(totalResults / pageSize))
  }
}

extension HomePageProvider {
  struct PrivateConstants {
    static let maxPageInitialValue: Int = 1
    static let pageIndexInitialValue: Int = 1
    static let pageIndexIncrementalValue: Int = 1
    static let defaultPageSize: Double = 10
  }
}
