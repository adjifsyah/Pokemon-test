//
//  UIImageView+Ext.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import UIKit

extension UIImageView {
    func downloaded(from str: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: str) else { return self.image = UIImage(named: "imgDefault") }
        downloaded(from: url, contentMode: mode)
    }
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
