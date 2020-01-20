//
//  HomeViewModel+TableViewConfig.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewModel.ResultView {
  var cellHeight: CGFloat {
    switch self {
    case .result:
      return 100
    case .placeholder:
      return 100
    }
  }
}

extension HomeViewModel.ResultView {
  var cellClass: BaseCell.Type {
    switch self {
    case .result:
      return MovieCell.self
    case .placeholder:
      return MoviePlaceholderCell.self
    }
  }
}
