//
//  BaseStatsCell.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 09/02/23.
//

import UIKit

class BaseStatsCell: UITableViewCell {
    @IBOutlet weak var lblStats: UILabel!
    @IBOutlet weak var lblValueStats: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setProgress(title: String, value: Int) {
        let filterTitle = title.components(separatedBy: "-").joined(separator: " ").capitalized
        self.lblStats.text = filterTitle
        self.lblValueStats.text = "\(value)"
        self.setupProgressBar(value: Float(value))
    }
    
    private func setupProgressBar(value: Float) {
        let valueToProgress = value / 100
        progressBar.progress = valueToProgress
    }
}
