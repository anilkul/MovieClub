//
//  SearchListCellViewModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

protocol CellTypable {
  var cellHeight: CGFloat { get }
  var cellClass: BaseCell.Type { get }
  var identifier: String { get }
}

protocol SearchListCellViewModelProtocol: AnyObject {
  func getCellHeight() -> CGFloat
  func getEstimatedHeight() -> CGFloat
  var cellType: CellTypable { get }
}


class SearchListCellViewModel: SearchListCellViewModelProtocol {
  var cellType: CellTypable = HomeViewModel.CellType.resultView(.result) {
    didSet {
      cellHeight = cellType.cellHeight
    }
  }
  
  var cellHeight: CGFloat = UITableView.automaticDimension {
    didSet {
      estimatedHeight = cellHeight
    }
  }
  
  var estimatedHeight: CGFloat = UITableView.automaticDimension
  
  func getCellHeight() -> CGFloat {
    return cellHeight
  }
  
  func getEstimatedHeight() -> CGFloat {
    return estimatedHeight
  }
  
  
}
