//
//  Awards.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 21.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

struct Awards {
  var count: Int
  var type: AwardType
  var image: UIImage {
    switch type {
    case .oscar:
      return UIImage(named: AwardType.oscar.rawValue)!
    case .goldenGlobe:
      return UIImage(named: AwardType.goldenGlobe.rawValue)!
    }
  }
}
