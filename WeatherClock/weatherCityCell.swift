//
//  weatherCityCell.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/25.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class weatherCityCell: UITableViewCell {

      @IBOutlet weak var city: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func weatherCity() -> weatherCityCell{
        return Bundle.main.loadNibNamed("weatherCityCell", owner: nil, options: nil)?[0] as! weatherCityCell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
