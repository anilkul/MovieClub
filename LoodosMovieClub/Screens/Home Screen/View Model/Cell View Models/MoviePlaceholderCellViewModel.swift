//
//  MovieCellPlaceholderViewModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

protocol MoviePlaceholderCellViewModelProtocol {
  
}

class MoviePlaceholderCellViewModel: SearchListCellViewModel, MoviePlaceholderCellViewModelProtocol {
  var pageProvider: HomePageProvider?
  
  override init() {
    super.init()
    self.cellType = HomeViewModel.CellType.resultView(.placeholder)
  }
}
