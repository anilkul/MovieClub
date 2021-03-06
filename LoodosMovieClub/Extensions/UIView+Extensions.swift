//
//  UIView+Extensions.swift
//  LoodosMovieClub
//
//  Created by Mehmet Anıl Kul on 20.01.2020.
//  Copyright © 2020 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

extension UIView {
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
      get {
          return layer.borderWidth
      }
      set {
          layer.borderWidth = newValue
      }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
      get {
          if let color = layer.borderColor {
              return UIColor(cgColor: color)
          }
          return nil
      }
      set {
          if let color = newValue {
              layer.borderColor = color.cgColor
          } else {
              layer.borderColor = nil
          }
      }
  }
  
  func startShimmering() {
    let light = UIColor.white.cgColor
    let alpha = UIColor.white.withAlphaComponent(0.7).cgColor
    
    let gradient = CAGradientLayer()
    gradient.colors = [alpha, light, alpha]
    gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
    gradient.locations = [0.4, 0.5, 0.6]
    self.layer.mask = gradient
    
    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = [0.0, 0.1, 0.2]
    animation.toValue = [0.8, 0.9, 1.0]
    animation.duration = 1.5
    animation.repeatCount = HUGE
    gradient.add(animation, forKey: "shimmer")
  }
}
