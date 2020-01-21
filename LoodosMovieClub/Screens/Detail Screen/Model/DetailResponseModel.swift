//
//  MovieDetailResponseModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 20.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

// MARK: - DetailResponseModel
struct MovieDetailResponseModel: Codable {
  let title, year, rated: String
  let genre, director, writer: String
  let actors, plot: String
  let awards: String
  let poster: String
  let ratings: [Rating]
  let imdbID: String
  let imdbRating: String
  let metascore: String?
//  let website, dvd, boxOffice, production, totalSeasons: String?
  let type, response: String
  
  enum CodingKeys: String, CodingKey {
    case title = "Title"
    case year = "Year"
    case rated = "Rated"
    case genre = "Genre"
    case director = "Director"
    case writer = "Writer"
    case actors = "Actors"
    case plot = "Plot"
    case awards = "Awards"
    case poster = "Poster"
    case ratings = "Ratings"
    case metascore = "Metascore"
    case imdbRating, imdbID
    case type = "Type"
    case response = "Response"
  }
}

// MARK: - Rating
struct Rating: Codable {
  let source, value: String
  
  enum CodingKeys: String, CodingKey {
    case source = "Source"
    case value = "Value"
  }
}
