//
//  CustomNetworkError.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 21.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

enum CustomError: Error, CustomStringConvertible {
  case responseFailure
  case responseUnavailable
  case custom(String)
  
  
  var description: String {
    switch self {
    case .responseFailure:
      return "ERROR: Could not get server response"
    case .responseUnavailable:
      return "ERROR: Response data is unavailable"
    case .custom(let error):
      return "\(error)"
    }
  }
}
