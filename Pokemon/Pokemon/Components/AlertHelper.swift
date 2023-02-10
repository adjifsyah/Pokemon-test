//
//  AlertHelper.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import UIKit

class AlertHelper {
    private init() { }
    static func showGeneralAlert(message: String, navigationController: UINavigationController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: message.description, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            navigationController.present(alert, animated: true, completion: nil)
        }
    }
}
