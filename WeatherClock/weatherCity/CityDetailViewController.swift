//
//  CityDetailViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/28.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    var cityInfo :JSON? = nil
    
    @IBOutlet weak var weatherDetailScrollView: UIScrollView!
    @IBOutlet weak var bg_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //设置背景和毛玻璃
        //根据当前时间和天气设置不同背景
        var bg_image : UIImage?
        bg_image = UIImage.init(imageLiteralResourceName: "天气-bg1")
        if cityInfo!["data"]["forecast"][0]["type"].stringValue != "晴" {
            bg_image = UIImage.init(imageLiteralResourceName: "天气-bg3")
        }else{
            // 获取当前系统时间
            let date = NSDate()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH"
            let time = timeFormatter.string(from: date as Date)
            if Int(time)! > 18{
                bg_image = UIImage.init(imageLiteralResourceName: "天气-bg4")
            }else if Int(time)! < 10{
                bg_image = UIImage.init(imageLiteralResourceName: "天气-bg2")
                
            }
        }
        let bg_imageView : UIImageView = UIImageView.init(image: bg_image)
        bg_imageView.frame = self.view.frame
        bg_view.addSubview(bg_imageView)
        let toolbar : UIToolbar = UIToolbar.init(frame: self.view.frame)
        bg_view.addSubview(toolbar)
        self.view.addSubview(bg_view)
        self.view.sendSubviewToBack(bg_view)
        //设置scrollview
        self.weatherDetailScrollView.contentSize = CGSize.init(width: self.weatherDetailScrollView.frame.width, height: self.weatherDetailScrollView.frame.height * 2)
        self.weatherDetailScrollView.bounces = false
        //添加城市信息view
        self.weatherDetailScrollView.addSubview(buildCityInfo())
        self.weatherDetailScrollView.addSubview(buildQihouInfo())
        self.weatherDetailScrollView.addSubview(buildWeatherInfo())
        self.weatherDetailScrollView.addSubview(buildTodayLimitInfo())
    }

    
    //城市与更新信息
    func buildCityInfo() -> UIView{
        //scrollview的信息
        let widthV = self.view.frame.width
        //初始化view
        let view = UIView.init()
        view.frame = CGRect.init(x: 10, y: 10, width: widthV - 36, height: 130)
        view.backgroundColor = nil
        //初始化省份label
        let parentName = UILabel.init()
        parentName.text = self.cityInfo!["cityInfo"]["parent"].stringValue
        parentName.textAlignment = NSTextAlignment.center
        parentName.font = UIFont.systemFont(ofSize: 24)
        parentName.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        parentName.frame = CGRect.init(x: 10, y: 10, width: view.frame.width - 20, height: 30)
        //初始化城市名label
        let cityName = UILabel.init()
        cityName.text = self.cityInfo!["cityInfo"]["city"].stringValue
        cityName.textAlignment = NSTextAlignment.center
        cityName.font = UIFont.systemFont(ofSize: 52)
        cityName.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        cityName.frame = CGRect.init(x: 10, y: 55, width: view.frame.width - 20, height: 50)
//        //初始化更新时间label
//        let updateTime = UILabel.init()
//        updateTime.text = "天气更新时间:" + self.cityInfo!["cityInfo"]["updateTime"].stringValue
//        updateTime.textAlignment = NSTextAlignment.center
//        updateTime.font = UIFont.systemFont(ofSize: 16)
//        updateTime.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        updateTime.frame = CGRect.init(x: 10, y: 110, width: view.frame.width - 20, height: 20)
        //添加视图
        view.addSubview(parentName)
        view.addSubview(cityName)
//        view.addSubview(updateTime)
        return view
    }

    //气候信息
    func buildQihouInfo() -> UIView{
        //scrollview的信息
        let widthV = self.view.frame.width
        //初始化view
        let view = UIView.init()
        view.frame = CGRect.init(x: 10, y: 150, width: widthV - 36, height: 90)
        view.backgroundColor = nil
        //初始化气候label
        let qihou = UILabel.init()
        qihou.text = self.cityInfo!["data"]["forecast"][0]["type"].stringValue
        qihou.textAlignment = NSTextAlignment.right
        qihou.font = UIFont.systemFont(ofSize: 24)
        qihou.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        qihou.frame = CGRect.init(x: 10, y: 20, width: (view.frame.width - 20) * 0.5 - 10, height: 50)
        //气候图标imageview
        let qihouIcon = UIImageView.init()
        let image = UIImage.init(named:self.cityInfo!["data"]["forecast"][0]["type"].stringValue )
        qihouIcon.frame = CGRect.init(x: (view.frame.width - 20) * 0.5 + 10, y: 20, width: 50, height: 50)
        qihouIcon.image = image
        //添加视图
        view.addSubview(qihou)
        view.addSubview(qihouIcon)
        return view
    }
    
    //温度信息
    func buildWeatherInfo() -> UIView{
        //scrollview的信息
        let widthV = self.view.frame.width
        //初始化view
        let view = UIView.init()
        view.frame = CGRect.init(x: 10, y: 240, width: widthV - 36, height: 110)
        view.backgroundColor = nil
        //初始化温度label
        let wendu = UILabel.init()
        wendu.text = self.cityInfo!["data"]["wendu"].stringValue + "℃"
        wendu.textAlignment = NSTextAlignment.center
        wendu.font = UIFont.systemFont(ofSize: 56)
        wendu.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        wendu.frame = CGRect.init(x: 10, y: 10, width: view.frame.width - 20, height: 50)
        //温度区间label
        let wendu_range = UILabel.init()
        wendu_range.text = self.cityInfo!["data"]["forecast"][0]["low"].stringValue + " -> " + self.cityInfo!["data"]["forecast"][0]["high"].stringValue
        wendu_range.textAlignment = NSTextAlignment.center
        wendu_range.font = UIFont.systemFont(ofSize: 24)
        wendu_range.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        wendu_range.frame = CGRect.init(x: 10, y: 80, width: view.frame.width - 20, height: 30)
        //添加视图
        view.addSubview(wendu)
        view.addSubview(wendu_range)
        return view
    }
    
    //今日限定data
    func buildTodayLimitInfo() -> UIView{
        //scrollview的信息
        let widthV = self.view.frame.width
        //初始化view
        let view = UIView.init()
        view.frame = CGRect.init(x: 10, y: 370, width: widthV - 36, height: 240)
        view.backgroundColor = nil
        //初始化label左边
        let label_l = UILabel.init()
        label_l.numberOfLines = 0
        label_l.text = "湿度:" + "\n\n空气质量:" +  "\n\npm2.5:" +  "\n\npm10:" + "\n\n感冒提醒:\n"
        label_l.textAlignment = NSTextAlignment.right
        label_l.font = UIFont.systemFont(ofSize: 18)
        label_l.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label_l.frame = CGRect.init(x: 10, y: 10, width: (view.frame.width - 20) * 0.5 - 5, height: 220)
        //初始化label右边
        let label_r = UILabel.init()
        label_r.numberOfLines = 0
        label_r.text = self.cityInfo!["data"]["shidu"].stringValue + "\n\n" + self.cityInfo!["data"]["quality"].stringValue +  "\n\n" + self.cityInfo!["data"]["pm25"].stringValue + "\n\n" + self.cityInfo!["data"]["pm10"].stringValue + "\n\n" + self.cityInfo!["data"]["ganmao"].stringValue + "\n"
        label_r.textAlignment = NSTextAlignment.left
        label_r.lineBreakMode = NSLineBreakMode.byClipping
        label_r.font = UIFont.systemFont(ofSize: 18)
        label_r.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label_r.frame = CGRect.init(x: 15 + (view.frame.width - 20) * 0.5, y: 10, width: (view.frame.width - 20) * 0.5 - 10, height: 220)
        view.addSubview(label_l)
        view.addSubview(label_r)
        return view
    }
}
