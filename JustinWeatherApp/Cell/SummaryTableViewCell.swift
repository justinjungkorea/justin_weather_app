//
//  SummaryTableViewCell.swift
//  JustinWeatherApp
//
//  Created by Dong Wook Jung on 12/07/2019.
//  Copyright © 2019 Dong Wook Jung. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    static let identifier = "SummaryTableViewCell"
    
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var minMaxLabel: UILabel!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        statusLabel.textColor = UIColor.white
        minMaxLabel.textColor = statusLabel.textColor
        currentTemperatureLabel.textColor = statusLabel.textColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
