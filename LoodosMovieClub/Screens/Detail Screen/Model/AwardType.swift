//
//  AwardType.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 21.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

enum AwardType: String {
  case oscar, goldenGlobe
  
  var string: String {
    switch self {
      
    case .oscar:
      return " Oscars"
    case .goldenGlobe:
      return " Golden Globes"
    }
  }
}
