//
//  ForecastTableViewCell.swift
//  JustinWeatherApp
//
//  Created by Dong Wook Jung on 12/07/2019.
//  Copyright © 2019 Dong Wook Jung. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let identifier = "ForecastTableViewCell"
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        statusLabel.textColor  = UIColor.white
        dateLabel.textColor = statusLabel.textColor 
        timeLabel.textColor = statusLabel.textColor
        temperatureLabel.textColor = statusLabel.textColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
