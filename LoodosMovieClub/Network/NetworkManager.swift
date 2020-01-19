//
//  NetworkManager.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 19.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
  func requestSearch(for movieTitle: String, on page: Int, completion: @escaping (RequestResult<MovieSearchResponseModel, CustomError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
  
  init() {
    print(" |||||| \(String(describing: self)) initialized")
  }
  
  deinit {
    print(" *** \(String(describing: self)) deninitialized")
  }
  
  private let defaultParams: [String: Any] = ["apikey": "295c53d4"]
  private let decoder = JSONDecoder()
  
  func requestSearch(for movieTitle: String, on page: Int, completion: @escaping (RequestResult<MovieSearchResponseModel, CustomError>) -> Void) {
    let params: [String: Any] = ["s": movieTitle, "page": page]
    let mergedParams = params.merging(defaultParams) { $1 }
    
    Alamofire.request(Constants.URLStrings.baseURLString, method: .get, parameters: mergedParams, encoding: URLEncoding.default).responseJSON { [unowned self] (response) in
      guard response.result.isSuccess else {
        completion(.failure(.responseFailure))
        return
      }
      
      guard let responseData = response.data  else {
          completion(.failure(.responseUnavailable))
          return
      }
      completion(self.decodeResponse(from: responseData, for: MovieSearchResponseModel.self))
    }
  }
  
  private func decodeResponse<T: Decodable>(from data: Data, for type: T.Type) -> RequestResult<T, CustomError> {
    do {
      let responseModel = try decoder.decode(T.self, from: data)
      return .success(responseModel)
    } catch {
      let failedResponseMessage = decodedFailedResponse(from: data)?.error ?? Constants.Strings.emptyString
      return .failure(.custom("Failed response message: \(failedResponseMessage)\nError:\(error.localizedDescription)"))
    }
  }
  
  private func decodedFailedResponse(from data: Data) -> FailedResponseModel? {
    do {
      let failedResponseModel = try decoder.decode(FailedResponseModel.self, from: data)
      return failedResponseModel
    } catch {
      printInDebug("Could not get failed response data: \(error)")
      return nil
    }
  }
}

enum CustomError: Error, CustomStringConvertible {
    case responseFailure
    case responseUnavailable
    case custom(String)
    
    
    var description: String {
        switch self {
        case .responseFailure:
            return "ERROR: Could not get server response"
        case .responseUnavailable:
            return "ERROR: Response data is unavailable"
        case .custom(let error):
            return "\(error)"
        }
    }
}
