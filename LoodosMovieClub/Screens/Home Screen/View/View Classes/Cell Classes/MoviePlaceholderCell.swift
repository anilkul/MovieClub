//
//  MoviePlaceholderCell.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

class MoviePlaceholderCell: BaseCell {
  
  @IBOutlet var placeholderViews: [UIView]!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func willDisplay() {
    super.willDisplay()
    placeholderViews.forEach { $0.startShimmering() }
    pageProvider?.loadMore()
  }
  
}
