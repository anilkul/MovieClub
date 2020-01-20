//
//  HomeViewModel+Enums.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

extension HomeViewModel {
  enum ResultView: Equatable, CaseIterable {
    case result, placeholder
  }
}

extension HomeViewModel {
  enum CellType: Equatable, CaseIterable, CellTypable {
    
    static var allCases: [CellType] {
      return ResultView.allCases.map(CellType.resultView)
    }
    
    case resultView(ResultView)
    
    var cellClass: BaseCell.Type {
      switch self {
      case .resultView(let innerCase):
        return innerCase.cellClass
    }
  }
    
    var cellHeight: CGFloat {
      switch self {
      case .resultView(let innerCase):
        return innerCase.cellHeight
      }
    }
    
    var identifier: String {
      cellClass.identifier()
    }
  }
}
