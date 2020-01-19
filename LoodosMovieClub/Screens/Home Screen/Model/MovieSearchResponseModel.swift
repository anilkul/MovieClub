//
//  MovieSearchResponseModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

// MARK: - MovieSearchResponseModel
struct MovieSearchResponseModel: Codable {
    let searchedMovie: [SearchedMovie]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case searchedMovie = "search"
        case totalResults
        case response
    }
}

enum TypeEnum: String, Codable {
    case game = "game"
    case movie = "movie"
    case series = "series"
}
