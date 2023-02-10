//
//  ListPokemonCell.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import UIKit

class ListPokemonCell: UITableViewCell {
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblPokemon: UILabel!
    
    @IBOutlet weak var backgroundCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func getPokemon(imageStr: String, name: String) {
        imgPokemon.downloaded(from: imageStr)
        lblPokemon.text = name.capitalized
    }
    
    private func setupCell() {
        backgroundCell.layer.cornerRadius = 4
        backgroundCell.layer.shadowColor = UIColor.black.cgColor
        backgroundCell.layer.shadowOpacity = 0.1
        backgroundCell.layer.shadowOffset = CGSize(width: 0, height: 1)
        backgroundCell.layer.shadowRadius = 3
    }
}
