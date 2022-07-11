//
//  UIView+Extension.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Foundation
import UIKit

extension UIView {
    //Set shadow for view
    func setShadow(withCornerRadius: Bool = true, radius: CGFloat = 5, opacity: Float = 0.1) {
        if withCornerRadius {
            layer.cornerRadius = radius
        }
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 6
        layer.shadowOpacity = opacity
    }
    
    // MARK: Activity Indicator
    
    func setActivityIndicator(show: Bool) {
        self.activityIndicator(show: show, style: .gray)
    }
    
    func activityIndicator(show: Bool, style: UIActivityIndicatorView.Style) {
        var spinner: UIActivityIndicatorView? = viewWithTag(NSIntegerMax - 1) as? UIActivityIndicatorView
        
        if spinner != nil {
            spinner?.removeFromSuperview()
            spinner = nil
        }
        
        if spinner == nil && show {
            spinner = UIActivityIndicatorView.init(style: style)
            spinner?.translatesAutoresizingMaskIntoConstraints = false
            spinner?.hidesWhenStopped = true
            spinner?.tag = NSIntegerMax - 1
            
            if Thread.isMainThread {
                spinner?.startAnimating()
            } else {
                DispatchQueue.main.async {
                    spinner?.startAnimating()
                }
            }
            
            insertSubview((spinner)!, at: 0)
            
            NSLayoutConstraint.init(item: spinner!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint.init(item: spinner!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
            
            spinner?.isHidden = !show
        }
    }
}
