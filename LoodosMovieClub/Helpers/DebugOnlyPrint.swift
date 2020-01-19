//
//  DebugOnlyPrint.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation

func printInDebug(_ item: Any, type: LogType = .normal) {
  #if DEBUG
    print(type.defaultLog)
    print(item)
  #endif
}

enum LogType {
  case normal, error, complete
  
  var defaultLog: String {
    switch self {
    case .normal:
      return Constants.Strings.emptySting
    case .error:
      return "❌ ERROR: "
    case .complete:
      return "✅ DONE: "
    }
  }
}
