//
//  MovieCellViewModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation
import UIKit

protocol MovieCellViewModelProtocol {
  var title: String { get set }
  var year: String { get set }
  var imdbID: String { get set }
  var type: String { get set }
  var posterURLString: String { get set }
}

class MovieCellViewModel: SearchListCellViewModel, MovieCellViewModelProtocol {
  var title: String
  var year: String
  var imdbID: String
  var type: String
  var posterURLString: String
  
  init(title: String, year: String, imdbID: String, type: String, posterURLString: String) {
    self.title = title
    self.year = year
    self.imdbID = imdbID
    self.type = type
    self.posterURLString = posterURLString
    super.init()
    self.cellType = HomeViewModel.CellType.resultView(.result)
  }
}
