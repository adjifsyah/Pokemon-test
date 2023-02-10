//
//  GeneralLoading.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 09/02/23.
//

import UIKit

class GeneralLoading {
    private init() { }
    
    static func showLoading(getNavigation: UINavigationController) {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        getNavigation.present(alert, animated: true, completion: nil)
    }
    
    static func hideLoading(getNavigation: UINavigationController) {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.stopAnimating()
        getNavigation.dismiss(animated: true)
    }
}
