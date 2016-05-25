//
//  WeekCell.swift
//  WeatherDemo
//
//  Created by xjc on 16/5/25.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class WeekCell: UITableViewCell {

    @IBOutlet weak var labelWeek: UILabel!
    @IBOutlet weak var labelToday: UILabel!
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    @IBOutlet weak var labelHTemp: UILabel!
    @IBOutlet weak var labelLTemp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
