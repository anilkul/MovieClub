//
//  String+Extensions.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 21.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

extension String {
  func slice(from: String, to: String) -> String? {
    return (range(of: from)?.upperBound).flatMap { substringFrom in
      (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
        String(self[substringFrom..<substringTo])
      }
    }
  }
}
