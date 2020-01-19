//
//  NetworkManager.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
  
}

class NetworkManager: NetworkManagerProtocol {
  
  init() {
    print(" |||||| \(String(describing: self)) initialized")
  }
  
  deinit {
    print(" *** \(String(describing: self)) deninitialized")
  }
}
