//
//  FailedResponseModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

// MARK: - FailedResponseModel
struct FailedResponseModel: Decodable {
    let response, error: String

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
}
