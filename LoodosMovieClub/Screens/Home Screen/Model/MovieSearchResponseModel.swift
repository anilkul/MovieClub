//
//  MovieSearchResponseModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

// MARK: - MovieSearchResponseModel
struct MovieSearchResponseModel: Decodable {
    let searchedMovies: [SearchedMovie]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case searchedMovies = "Search"
        case totalResults
        case response = "Response"
    }
}

enum TypeEnum: String, Decodable {
    case game = "game"
    case movie = "movie"
    case series = "series"
}
