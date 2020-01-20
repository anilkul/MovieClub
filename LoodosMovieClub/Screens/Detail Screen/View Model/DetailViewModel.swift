//
//  DetailViewModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 20.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol {
  var imdbID: String { get set }
  var networkManager: NetworkManagerProtocol { get set }
}

class DetailViewModel: DetailViewModelProtocol {
  var imdbID: String
  var networkManager: NetworkManagerProtocol
  
  init(imdbID: String, networkManager: NetworkManagerProtocol) {
    self.imdbID = imdbID
    self.networkManager = networkManager
  }
}
