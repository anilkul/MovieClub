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
}
