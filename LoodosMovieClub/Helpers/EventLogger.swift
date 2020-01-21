//
//  EventLogger.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 21.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation
import FirebaseAnalytics

struct EventLogger {
  static func logEvent(event: AnalyticsEvent, key: AnalyticsParamKey, value: String) {
    Analytics.logEvent(event.rawValue, parameters: [key.rawValue: (value as NSObject)])
  }
}

enum AnalyticsEvent: String {
  case searchTerm
  case movieDetail
}

enum AnalyticsParamKey: String {
  case title
  case year
  case director
}
