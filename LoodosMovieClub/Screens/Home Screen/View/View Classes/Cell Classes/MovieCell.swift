//
//  MovieCell.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: BaseCell {
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var typeImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCell()
  }
  
  func configureCell() {
    workerBlock = { [weak self] cellViewModel in
      guard let self = self else { return }
      guard let cellViewModel = cellViewModel as? MovieCellViewModelProtocol else {
        printInDebug(Constants.Strings.emptyString, type: .error)
        fatalError("Cell: \(String(describing: self)) is not convertable")
      }
      self.titleLabel.text = cellViewModel.title
      self.yearLabel.text = cellViewModel.year
      self.posterImageView.kf.indicatorType = .activity
      self.posterImageView.kf.setImage(with: URL(string: cellViewModel.posterURLString)!, placeholder: UIImage(named: "movie_placeholder")!)
      self.posterImageView.isHidden = self.posterImageView.image == nil
      self.typeImageView.image = UIImage(named: cellViewModel.type)
    }
  }
}
