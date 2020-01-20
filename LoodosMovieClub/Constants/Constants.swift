//
//  Constants.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

// MARK: - Constants
struct Constants {
  
  struct Strings {
    static var companyName: String = RemoteConfigValues.shared.remoteConfigString(for: .companyName)
    static var emptyString: String = ""
  }
  
  struct URLStrings {
    static var baseURLString: String = "https://www.omdbapi.com/"
  }
}

// MARK: - Typealiases
typealias VoidHandler = () -> Void
