//
//  SplashViewModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation
import Reachability

protocol SplashViewModelProtocol {
  var hasConnection: Bool { get }
}

class SplashViewModel: SplashViewModelProtocol {
  
  // MARK: - Variables
  var hasConnection: Bool {
    guard let reachability = Reachability() else { return false }
    return reachability.connection != .none
  }
  
}
