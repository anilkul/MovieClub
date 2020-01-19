//
//  RemoteConfigValues.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

import Foundation
import Firebase

enum RemoteConfigKey: String {
  case companyName
}

class RemoteConfigValues {
  
  static let shared = RemoteConfigValues()
  
  private init() {
    defaultValues()
    fetchCloudValues()
    activateDebugMode()
  }
  
  func defaultValues() {
    let appDefaults: [String: Any?] = [
      RemoteConfigKey.companyName.rawValue : "DH"
    ]
    RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
  }
  
  func fetchCloudValues() {
    let fetchDuration: TimeInterval = 0
    RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { status, error in
      
      if let error = error {
        printInDebug("Could not fetch remote values: \(error)", type: .error)
        return
      }
      
      RemoteConfig.remoteConfig().activateFetched()
      printInDebug("Obtained remote values", type: .complete)
      
      let companyName = RemoteConfig.remoteConfig()
        .configValue(forKey: "companyName")
        .stringValue ?? "undefined"
      print("Company: \(companyName)")
    }
  }
  
  func activateDebugMode() {
    let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
    RemoteConfig.remoteConfig().configSettings = debugSettings
  }
  
  func remoteConfigString(for key: RemoteConfigKey) -> String {
    return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
  }
}
