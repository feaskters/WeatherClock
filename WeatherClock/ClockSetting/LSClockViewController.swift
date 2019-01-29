//
//  LSClockViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/29.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class LSClockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置背景
        let image = UIImage.init(named: "时钟页面背景")
        let imageView_bg = UIImageView.init(image: image)
        imageView_bg.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(imageView_bg)
        self.view.sendSubviewToBack(imageView_bg)
    }
    

}
