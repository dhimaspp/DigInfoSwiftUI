//
//  LoadingState.swift
//  Diginfo
//
//  Created by Dhimas P Pangestu on 29/03/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        view.subviews
            .compactMap { $0 as? UIActivityIndicatorView }
            .forEach { $0.removeFromSuperview() }
    }
}
