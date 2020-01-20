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
  
  var title: String { get set }
  var posterUrlString: String { get set }
  var genre: String { get set }
  var rated: String { get set }
  var type: String { get set }
  
  // var ratings
  
  var plot: String { get set }
  var director: String { get set }
  var writer: String { get set }
  var actors: String { get set }
}

class DetailViewModel: DetailViewModelProtocol {
  var title: String
  var posterUrlString: String
  var genre: String
  
  var rated: String
  var type: String
  var plot: String
  
  var director: String
  var writer: String
  var actors: String
  
  var imdbID: String
  var networkManager: NetworkManagerProtocol
  
  init(imdbID: String, networkManager: NetworkManagerProtocol) {
    title = Constants.Strings.emptyString
    posterUrlString = Constants.Strings.emptyString
    genre = Constants.Strings.emptyString
    
    rated = Constants.Strings.emptyString
    type = Constants.Strings.emptyString
    plot = Constants.Strings.emptyString
    
    director = Constants.Strings.emptyString
    writer = Constants.Strings.emptyString
    actors = Constants.Strings.emptyString
    
    self.imdbID = imdbID
    self.networkManager = networkManager
    
    fetchMovieDetail(for: imdbID)
  }
  
  private func fetchMovieDetail(for imdbID: String) {
    
  }
  
  private func parseMovieDetail() {
    
  }
  
  private func configureMovieDetail() {
    
  }
}
