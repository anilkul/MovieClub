//
//  MovieCell.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

class MovieCell: BaseCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configureCell() {
    workerBlock = { [weak self] cellViewModel in
      guard let self = self else { return }
      guard let cellViewModel = cellViewModel as? MovieCellViewModelProtocol else {
        printInDebug(Constants.Strings.emptyString, type: .error)
        fatalError("Cell: \(String(describing: self)) is not convertable")
      }
      
    }
  }
  
}
