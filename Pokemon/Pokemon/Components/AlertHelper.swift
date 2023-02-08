//
//  AlertHelper.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import UIKit

class AlertHelper {
    func showGeneralAlert(message: String, navigationController: UINavigationController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in })
        alert.addAction(okAction)
        navigationController.present(alert, animated: true)
    }
}
