//
//  HomeParser.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

protocol HomeParserProtocol {
  func parseSearchedMovies(searchedMovies: [SearchedMovie]) -> [SearchListCellViewModelProtocol]
}

class HomeParser: HomeParserProtocol {
  
  func parseSearchedMovies(searchedMovies: [SearchedMovie]) -> [SearchListCellViewModelProtocol] {
    var dataSource: [SearchListCellViewModelProtocol] = []
    searchedMovies.forEach { (searchedMovie) in
      dataSource.append(createMovieCellViewModel(for: searchedMovie))
    }
    dataSource.append(MoviePlaceholderCellViewModel())
    return dataSource
  }
  
  private func createMovieCellViewModel(for searchedMovie: SearchedMovie) -> SearchListCellViewModelProtocol {
    return MovieCellViewModel(title: searchedMovie.title,
                              year: searchedMovie.year,
                              imdbID: searchedMovie.imdbID,
                              type: searchedMovie.type.rawValue,
                              posterURLString: searchedMovie.poster)
  }
  
  init() {
    print(" |||||| \(String(describing: self)) initialized")
  }
  
  deinit {
    print(" *** \(String(describing: self)) deninitialized")
  }
}
