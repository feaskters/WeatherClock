//
//  weatherCityCell.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/25.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class weatherCityCell: UITableViewCell {

    @IBOutlet weak var wendu: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var city: UILabel!
    var info :JSON = JSON.init("")
    
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
        self.wendu.text = (info["data"]["wendu"].stringValue + "℃")
        self.type.text = (info["data"]["forecast"][0]["type"].stringValue)
        self.city.text = (info["cityInfo"]["city"].stringValue)
        
    }
}
