//
//  DetailViewController.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 20.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit
import Kingfisher
import EFCountingLabel

class DetailViewController: BaseViewController {
  
  // MARK: - Variables
  /// - IBOutlets
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var typeImageView: UIImageView!
  @IBOutlet weak var imdbLabel: EFCountingLabel!
  @IBOutlet weak var awardsContainerView: UIView!
  @IBOutlet weak var awardsStackView: UIStackView!
  
  @IBOutlet weak var plotLabel: UILabel!
  @IBOutlet weak var directorLabel: UILabel!
  @IBOutlet weak var writerLabel: UILabel!
  @IBOutlet weak var actorsLabel: UILabel!
  
  @IBOutlet weak var upperView: UIView!
  @IBOutlet weak var ratingView: UIView!
  @IBOutlet weak var awardsInfoStackView: UIStackView!
  
  /// - Public Variables
  var viewModel: DetailViewModel!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.loadData = loadUI()
    viewModel.toggleLoadingView = toggleLoadingView()
    viewModel.fetchMovieDetail()
  }
  
  // MARK: - UI
  func configureUI() {
    titleLabel.text = viewModel.title
    yearLabel.text = viewModel.year
    posterImageView.kf.indicatorType = .activity
    posterImageView.kf.setImage(with: URL(string: viewModel.posterUrlString), placeholder: Constants.Images.moviePlaceholder)
    genreLabel.text = viewModel.genre
    typeImageView.image = viewModel.typeImage
    
    imdbLabel.text = String(viewModel.imdbRating)
    
    populateAwardsStackView(with: viewModel.awards?.image, for: viewModel.awards?.count)
    awardsContainerView.isHidden = awardsStackView.arrangedSubviews.isEmpty
    
    plotLabel.text = viewModel.plot
    directorLabel.text = viewModel.director
    writerLabel.text = viewModel.writer
    actorsLabel.text = viewModel.actors
  }
  
  private func populateAwardsStackView(with image: UIImage?, for imageCount: Int?) {
    guard let imageCount = imageCount, imageCount != 0 else { return }
    for _ in 0...imageCount - 1 {
      let awardImageView = UIImageView(image: image?.withRenderingMode(.alwaysTemplate))
      awardImageView.tintColor = Constants.Colors.defaultTextColor
      awardImageView.alpha = PrivateConstants.stackViewAnimationInitialAlpha
      awardImageView.contentMode = .scaleAspectFit
      self.awardsStackView.addArrangedSubview(awardImageView)
      self.awardsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func showViews() {
    upperView.isHidden = false
    ratingView.isHidden = false
    awardsInfoStackView.isHidden = false
  }
  
  
  // MARK: - Animation
  private func startAnimate() {
    animate(flatStackView: awardsStackView, at: PrivateConstants.stackViewAnimationInitialIndex)
    animateRatingLabels()
  }
  
  private func animate(flatStackView: UIStackView ,at elementIndex: Int, for duration: Double = PrivateConstants.stackViewAnimationDuration) {
    guard elementIndex != flatStackView.arrangedSubviews.count else { return }
    self.view.layoutIfNeeded()
    UIView.animate(withDuration: duration, delay: PrivateConstants.stackViewAnimationDelay, options: [.allowAnimatedContent], animations: {
      flatStackView.arrangedSubviews[elementIndex].alpha = PrivateConstants.stackViewAnimationDesiredAlpha
      flatStackView.layoutIfNeeded()
    }) { _ in
      self.animate(flatStackView: flatStackView, at: elementIndex + PrivateConstants.stackViewAnimationIncrementalValue)
    }
  }
  
  private func animateRatingLabels() {
    imdbLabel.format = Constants.Strings.labelFormat
    imdbLabel.method = EFLabelCountingMethod.easeOut
    imdbLabel.countFromZeroTo(CGFloat(viewModel.imdbRating), withDuration: PrivateConstants.labelAnimationDuration)
  }
  
  
  // MARK: - IBActions
  @IBAction func closeButtonTapped(_ sender: Any) {
    self.dismiss(animated: true)
  }
}

extension DetailViewController {
  func loadUI() -> VoidHandler {
    return { [weak self] in
      DispatchQueue.main.async {
        guard let self = self else { return }
        self.loadingView.dismiss()
        self.configureUI()
        self.showViews()
        self.startAnimate()
      }
    }
  }
}

extension DetailViewController {
  struct PrivateConstants {
    /// - Animation
    static let labelAnimationDuration: Double = 3.0
    static let stackViewAnimationInitialAlpha: CGFloat = 0
    static let stackViewAnimationDesiredAlpha: CGFloat = 1
    static let stackViewAnimationInitialIndex: Int = 0
    static let stackViewAnimationDuration: Double = 0.3
    static let stackViewAnimationDelay: Double = 0
    static let stackViewAnimationIncrementalValue: Int = 1
  }
}
