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
        let indicatorLoading = UIActivityIndicatorView(frame: CGRect(x: (self.image?.size.height ?? 0) / 2, y: (self.image?.size.height ?? 0) / 2, width: 20, height: 20))
        self.addSubview(indicatorLoading)
        indicatorLoading.isHidden = false
        indicatorLoading.startAnimating()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                indicatorLoading.stopAnimating()
                indicatorLoading.isHidden = true
            }
        }.resume()
    }
}
