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
  func requestDetail(for imdbID: String, completion: @escaping (RequestResult<MovieDetailResponseModel, CustomError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {

  private let defaultParams: [String: Any] = [NetworkParameter.apiKey.key: NetworkParameter.apiKey.apikeyValue]
  private let decoder = JSONDecoder()
  
  // MARK: - Requests
  func requestSearch(for movieTitle: String, on page: Int, completion: @escaping (RequestResult<MovieSearchResponseModel, CustomError>) -> Void) {
    let params: [String: Any] = [NetworkParameter.searchTitle.key: movieTitle, NetworkParameter.page.key: page]
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
  
  func requestDetail(for imdbID: String, completion: @escaping (RequestResult<MovieDetailResponseModel, CustomError>) -> Void) {
    let params: [String: Any] = [NetworkParameter.imdbID.key: imdbID]
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
      completion(self.decodeResponse(from: responseData, for: MovieDetailResponseModel.self))
    }
  }
  
  // MARK: - Decoding
  private func decodeResponse<T: Decodable>(from data: Data, for type: T.Type) -> RequestResult<T, CustomError> {
    do {
      let responseModel = try decoder.decode(T.self, from: data)
      return .success(responseModel)
    } catch {
      let failedResponseMessage = decodedFailedResponse(from: data)?.error ?? Constants.Strings.emptyString
      printInDebug("Error:\(error.localizedDescription)", type: .error)
      return .failure(.custom(failedResponseMessage))
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
  
  // MARK: -
  private enum NetworkParameter {
    case searchTitle, imdbID, page, apiKey
    
    var key: String {
      switch self {
      case .searchTitle:
        return "s"
      case .imdbID:
        return "i"
      case .page:
        return "page"
      case .apiKey:
        return "apiKey"
      }
    }
    
    var apikeyValue: String {
      return "295c53d4"
    }
  }
  
}
