//
//  ViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/25.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        //若是第一和第三个页面，点击tabitem时返回首页
        if item.tag == 0 || item.tag == 2 {
            (self.viewControllers![item.tag] as! UINavigationController).popToRootViewController(animated: true)
        }
    }
}

