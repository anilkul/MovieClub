//
//  Constants.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Constants
struct Constants {
  
  // MARK: - Strings
  struct Strings {
    /// - General
    static let emptyString: String = ""
    
    /// - Remote Config
    static let companyName: String = RemoteConfigValues.shared.remoteConfigString(for: .companyName)
    
    /// - Awards
    static let wonString = "Won "
    static let oscarString = " Oscars"
    static let goldenGlobeString = " Golden Globes"
    
    /// - Animation
    static let labelFormat = "%.1f"
    static let loadingText = "Loading"
    
    /// - Alert
    static let alertTitle = "Error"
    static let alertActionTitle = "OK"
  }
  
  // MARK: - Images
  struct Images {
    static let emptyImage: UIImage = UIImage()
    static let moviePlaceholder: UIImage = UIImage(named: "movie_placeholder")!
  }
  
  // MARK: - URLStrings
  struct URLStrings {
    static let baseURLString: String = "https://www.omdbapi.com/"
  }
  
  // MARK: - Colors
  struct Colors {
    static let defaultTextColor: UIColor = UIColor(hexString: "#CFCFCF")
  }
  
}

// MARK: - Typealiases
typealias VoidHandler = () -> Void
typealias BoolHandler = (Bool) -> Void
typealias StringHandler = (String) -> Void
