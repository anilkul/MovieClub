//
//  HomeManager.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

protocol HomeManagerProtocol: AnyObject {
  var viewModel: HomeViewModelProtocol { get set }
  var parser: HomeParserProtocol { get set }
  var networkManager: NetworkManagerProtocol { get set }
  var pageProvider: HomePageProviderProtocol { get set }
}

class HomeManager: HomeManagerProtocol {
  
  init() {
    viewModel.pageProvider = pageProvider
  }
  
  lazy var viewModel: HomeViewModelProtocol = {
    return HomeViewModel()
  }()
  
  lazy var parser: HomeParserProtocol = {
    return HomeParser()
  }()
  
  lazy var networkManager: NetworkManagerProtocol = {
    return NetworkManager()
  }()
  
  lazy var pageProvider: HomePageProviderProtocol = {
    return HomePageProvider(viewModel: viewModel, networkManager: networkManager, parser: parser)
  }()
  
}
