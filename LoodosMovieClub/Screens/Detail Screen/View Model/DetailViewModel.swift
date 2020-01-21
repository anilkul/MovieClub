//
//  DetailViewModel.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 20.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
  /// - Protocol Variables
  var imdbID: String { get set }
  var networkManager: NetworkManagerProtocol { get set }
  
  var title: String { get set }
  var year: String { get set }
  var posterUrlString: String { get set }
  var genre: String { get set }
  var type: String { get set }
  
  var ratings: [Rating] { get set }
  var imdbRating: Double { get set }
  
  var awardsString: String { get set }
  var awards: Awards? { get set }
  
  var plot: String { get set }
  var director: String { get set }
  var writer: String { get set }
  var actors: String { get set }
  
  /// - Protocol Closures
  var toggleLoadingView: BoolHandler? { get set }
  var loadData: VoidHandler? { get set }
  
  func fetchMovieDetail()
}

final class DetailViewModel: DetailViewModelProtocol {
  
  // MARK: - Variables
  var title: String
  var year: String
  var posterUrlString: String
  var genre: String
  var type: String
  var typeImage: UIImage
  
  var ratings: [Rating]
  var imdbRating: Double
  
  var awardsString: String
  var awards: Awards?
  
  var plot: String
  var director: String
  var writer: String
  var actors: String
  
  var imdbID: String
  var networkManager: NetworkManagerProtocol
  
  var labelIncrementAnimationFormat: String
  
  /// - Closures
  var toggleLoadingView: BoolHandler?
  var loadData: VoidHandler?
  
  init(imdbID: String, networkManager: NetworkManagerProtocol) {
    self.imdbID = imdbID
    self.networkManager = networkManager
    
    title = Constants.Strings.emptyString
    year = Constants.Strings.emptyString
    posterUrlString = Constants.Strings.emptyString
    genre = Constants.Strings.emptyString
    type = Constants.Strings.emptyString
    typeImage = Constants.Images.emptyImage
    
    ratings = []
    imdbRating = PrivateConstants.defaultImdbRating
    
    awardsString = Constants.Strings.emptyString
    awards = Awards(count: PrivateConstants.defaultAwardCount, type: .oscar)
    
    plot = Constants.Strings.emptyString
    director = Constants.Strings.emptyString
    writer = Constants.Strings.emptyString
    actors = Constants.Strings.emptyString
    
    labelIncrementAnimationFormat = Constants.Strings.emptyString
  }
  
  func fetchMovieDetail() {
    fetchMovieDetail(for: imdbID)
  }
  
  // MARK: Fetch
  private func fetchMovieDetail(for imdbID: String) {
    toggleLoadingView?(true)
    networkManager.requestDetail(for: imdbID) { [weak self] (requestResult) in
      guard let self = self else { return }
      switch requestResult {
      case .success(let movieDetailResponseModel):
        EventLogger.logEvent(event: .movieDetail, key: .title, value: movieDetailResponseModel.title)
        EventLogger.logEvent(event: .movieDetail, key: .year, value: movieDetailResponseModel.year)
        EventLogger.logEvent(event: .movieDetail, key: .director, value: movieDetailResponseModel.director)
        DispatchQueue.global(qos: .userInitiated).async {
          self.parseMovieDetail(for: movieDetailResponseModel)
          self.configureMovieDetail()
        }
        self.loadData?()
        
      case .failure(let error):
        self.toggleLoadingView?(false)
        printInDebug(error.description, type: .error)
      }
    }
  }
  
  // MARK: - Parse
  private func parseMovieDetail(for movieDetailResponseModel: MovieDetailResponseModel) {
    title = movieDetailResponseModel.title
    posterUrlString = movieDetailResponseModel.poster
    genre = movieDetailResponseModel.genre
    type = movieDetailResponseModel.type
    
    ratings = movieDetailResponseModel.ratings
    imdbRating = (movieDetailResponseModel.imdbRating as NSString).doubleValue
    
    awardsString = movieDetailResponseModel.awards
    
    plot = movieDetailResponseModel.plot
    director = movieDetailResponseModel.director
    writer = movieDetailResponseModel.writer
    actors = movieDetailResponseModel.actors
  }
  
  // MARK: - Configure
  private func configureMovieDetail() {
    typeImage = UIImage(named: type) ?? Constants.Images.emptyImage
    awards = fetchAwards(for: awardsString)
  }
  
  private func fetchAwards(for awardString: String) -> Awards? {
    guard !awardString.isEmpty, (awardString.contains(PrivateConstants.wonString) && (awardString.contains(AwardType.oscar.string) || awardString.contains(AwardType.goldenGlobe.string))) else { return nil }
    let awardType: AwardType = awardString.contains(AwardType.oscar.string) ? .oscar : .goldenGlobe
    let slicedString = awardString.slice(from: PrivateConstants.wonString, to: awardType.string) ?? Constants.Strings.emptyString
    let awardCount: Int = Int(slicedString) ?? PrivateConstants.defaultAwardCount
    return Awards(count: awardCount, type: awardType)
  }
}

extension DetailViewModel {
  struct PrivateConstants {
    static let wonString = Constants.Strings.wonString
    static let defaultAwardCount = 0
    static let defaultImdbRating: Double = 0
  }
}
