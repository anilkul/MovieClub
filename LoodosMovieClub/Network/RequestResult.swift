//
//  RequestResult.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

enum RequestResult<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}
