//
//  UITableViewCell+Extensions.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 20.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

extension UITableViewCell {
  static func identifier() -> String {
    return String(describing: self)
  }
}
