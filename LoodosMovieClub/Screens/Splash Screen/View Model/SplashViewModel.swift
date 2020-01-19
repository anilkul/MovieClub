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
    do {
      let reachability = try Reachability()
      return reachability.connection != .unavailable
    } catch {
      print(error)
    }
    return false
  }
  
}
