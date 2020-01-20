//
//  BaseCell.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

protocol BaseTableViewCellProtocol {
  var indexPath: IndexPath! { get set }
  var cellViewModel: SearchListCellViewModelProtocol! { get set }
  var pageProvider: HomePageProviderProtocol? { get set }
  func willDisplay()
  func configureCell(with cellViewModel: SearchListCellViewModelProtocol, for indexPath: IndexPath)
}

class BaseCell: UITableViewCell, BaseTableViewCellProtocol {
  var pageProvider: HomePageProviderProtocol?
  var indexPath: IndexPath!
  var cellViewModel: SearchListCellViewModelProtocol!
  var workerBlock: ((SearchListCellViewModelProtocol) throws -> Void)?
  func configureCell(with cellViewModel: SearchListCellViewModelProtocol, for indexPath: IndexPath) {
    self.indexPath = indexPath
    self.cellViewModel = cellViewModel
    
    do {
      try self.workerBlock?(cellViewModel)
    } catch {
      fatalError("Cell configure error for \(String(describing: cellViewModel)): \(error.localizedDescription)")
    }
  }
  
  func willDisplay() {}
}
