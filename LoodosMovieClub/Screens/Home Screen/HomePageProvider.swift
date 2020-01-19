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
}

class HomePageProvider: HomePageProviderProtocol {
  weak var viewModel: HomeViewModelProtocol!
  var networkManager: NetworkManagerProtocol
  var parser: HomeParserProtocol
  
  init(viewModel: HomeViewModelProtocol, networkManager: NetworkManagerProtocol, parser: HomeParserProtocol) {
    self.viewModel = viewModel
    self.networkManager = networkManager
    self.parser = parser
    print(" |||||| \(String(describing: self)) initialized")
  }
  
  deinit {
    print(" *** \(String(describing: self)) deninitialized")
  }
  
  func searchForMovie(with title: String, on page: Int) {
    networkManager.requestSearch(for: title, on: page) { [weak self] (requestResult) in
      guard let self = self else { return }
      switch requestResult {
      case .success(let movieSearchResponseModel):
        printInDebug(movieSearchResponseModel)
        // Parser'a yolla ve cellViewModel al
        // CellViewModel'lari viewmodel'a yolla
      case .failure(let error):
        printInDebug(error.description, type: .error)
      }
    }
  }
}
