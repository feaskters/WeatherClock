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
    var insideView :UIView!
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
        self.weatherDetailScrollView.contentSize = CGSize.init(width: self.weatherDetailScrollView.frame.width, height: 1000)
        self.weatherDetailScrollView.bounces = false
        //设置segement
        //添加城市信息view
        insideView = UIView.init()
        insideView.frame = CGRect.init(x:0,y:0,width: self.weatherDetailScrollView.frame.width, height: 1000)
        insideView.addSubview(todayWeatherView())
        self.weatherDetailScrollView.addSubview(insideView)
    }
    //segement事件
    @IBAction func selectDate(_ sender: UISegmentedControl) {
        //动画淡出
        UIView.animate(withDuration: 0.5, animations: {
            self.insideView.alpha = 0
        }) { (Bool) in
            if  Bool == true {
                self.insideView.removeFromSuperview()
                self.insideView = nil
                //重新创建insideview
                self.insideView = UIView.init()
                self.insideView.frame = CGRect.init(x:0,y:0,width: self.weatherDetailScrollView.frame.width, height: 1000)
                self.insideView.alpha = 0
                //判断点击
                if sender.selectedSegmentIndex == 0 {
                    self.insideView.addSubview(self.todayWeatherView())
                }else{
                    self.insideView.addSubview(self.forecastWeatherView(day: sender.selectedSegmentIndex))
                }
                self.weatherDetailScrollView.addSubview(self.insideView)
                
                //动画淡入
                UIView.animate(withDuration: 0.5, animations: {
                    self.insideView.alpha = 1
                    self.weatherDetailScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                })
               
            }
        }
       
    }
    //未来的天气view
    func forecastWeatherView(day:Int) -> UIView {
        //scrollview的信息
        let widthV = self.view.frame.width
        //新建view
        let view = UIView.init()
        view.frame = CGRect.init(x:0,y:0,width: self.weatherDetailScrollView.frame.width, height: 1000)
        view.addSubview(buildCityInfo())
        view.addSubview(buildQihouInfo(day: day))
        view.addSubview(buildWeatherInfo(day: day))
        //重生底部两个view
        let viewFor = buildForcasInfo(day: day)
        viewFor.frame = CGRect.init(x: 10, y: 290, width: widthV - 36, height: 240)
        let viewUp = buildUpdateTime()
        viewUp.frame = CGRect.init(x: 10, y: 540, width: widthV - 36, height: 50)
        view.addSubview(viewFor)
        view.addSubview(viewUp)
        return view
    }
    
    //今日天气的view
    func todayWeatherView() -> UIView {
        let view = UIView.init()
        view.frame = CGRect.init(x:0,y:0,width: self.weatherDetailScrollView.frame.width, height: 1000)
        view.addSubview(buildCityInfo())
        view.addSubview(buildQihouInfo(day: 0))
        view.addSubview(buildWeatherInfo(day: 0))
        view.addSubview(buildTodayLimitInfo())
        view.addSubview(buildForcasInfo(day: 0))
        view.addSubview(buildUpdateTime())
        return view
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
    func buildQihouInfo(day:Int) -> UIView{
        //scrollview的信息
        let widthV = self.view.frame.width
        //初始化view
        let view = UIView.init()
        view.frame = CGRect.init(x: 10, y: 150, width: widthV - 36, height: 90)
        view.backgroundColor = nil
        //初始化气候label
        let qihou = UILabel.init()
        qihou.text = self.cityInfo!["data"]["forecast"][day]["type"].stringValue
        qihou.textAlignment = NSTextAlignment.right
        qihou.font = UIFont.systemFont(ofSize: 24)
        qihou.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        qihou.frame = CGRect.init(x: 10, y: 20, width: (view.frame.width - 20) * 0.5 - 10, height: 50)
        //气候图标imageview
        var imagename = self.cityInfo!["data"]["forecast"][day]["type"].stringValue
        if  imagename == "中雨" || imagename == "大雨"{
            imagename = "小雨"
        }
        let qihouIcon = UIImageView.init()
        var image = UIImage.init(named:imagename)
        if image == nil {
            image = UIImage.init(named: "天气助手")
        }
        qihouIcon.frame = CGRect.init(x: (view.frame.width - 20) * 0.5 + 10, y: 20, width: 50, height: 50)
        qihouIcon.image = image
        //添加视图
        view.addSubview(qihou)
        view.addSubview(qihouIcon)
        return view
    }
    
    //温度信息
    func buildWeatherInfo(day:Int) -> UIView{
        //scrollview的信息
        let widthV = self.view.frame.width
        //初始化view
        let view = UIView.init()
        view.frame = CGRect.init(x: 10, y: 240, width: widthV - 36, height: 110)
        view.backgroundColor = nil
        //区分不同日期的ui
        var wendu_height :Float = 50
        var wendu_range_y :Float = 80
        if day == 0 {
            wendu_height = 50
            wendu_range_y = 80
        }else{
            wendu_height = 0
            wendu_range_y = 10
        }
        //初始化温度label
        let wendu = UILabel.init()
        wendu.text = self.cityInfo!["data"]["wendu"].stringValue + "℃"
        wendu.textAlignment = NSTextAlignment.center
        wendu.font = UIFont.systemFont(ofSize: 56)
        wendu.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        wendu.frame = CGRect.init(x: CGFloat(10), y: CGFloat(10), width: view.frame.width - 20, height: CGFloat(wendu_height))
        //温度区间label
        let wendu_range = UILabel.init()
        wendu_range.text = self.cityInfo!["data"]["forecast"][day]["low"].stringValue + " -> " + self.cityInfo!["data"]["forecast"][day]["high"].stringValue
        wendu_range.textAlignment = NSTextAlignment.center
        wendu_range.font = UIFont.systemFont(ofSize: 24)
        wendu_range.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        wendu_range.frame = CGRect.init(x: CGFloat(10), y: CGFloat(wendu_range_y), width: view.frame.width - 20, height: CGFloat(30))
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
        label_l.text = "湿度:" + "\n\n空气质量:" +  "\n\npm2.5:" +  "\n\npm10:"
        label_l.textAlignment = NSTextAlignment.right
        label_l.font = UIFont.systemFont(ofSize: 18)
        label_l.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label_l.frame = CGRect.init(x: 10, y: 10, width: (view.frame.width - 20) * 0.5 - 5, height: 160)
        //初始化label右边
        let label_r = UILabel.init()
        label_r.numberOfLines = 0
        label_r.text = self.cityInfo!["data"]["shidu"].stringValue + "\n\n" + self.cityInfo!["data"]["quality"].stringValue +  "\n\n" + self.cityInfo!["data"]["pm25"].stringValue + "\n\n" + self.cityInfo!["data"]["pm10"].stringValue + "\n"
        label_r.textAlignment = NSTextAlignment.left
        label_r.lineBreakMode = NSLineBreakMode.byClipping
        label_r.font = UIFont.systemFont(ofSize: 18)
        label_r.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label_r.frame = CGRect.init(x: 15 + (view.frame.width - 20) * 0.5, y: 10, width: (view.frame.width - 20) * 0.5 - 10, height: 160)
        //初始化label底部
        let label_d = UILabel.init()
        label_d.numberOfLines = 0
        label_d.text = "感冒提醒:" + self.cityInfo!["data"]["ganmao"].stringValue + "\n"
        label_d.textAlignment = NSTextAlignment.left
        label_d.lineBreakMode = NSLineBreakMode.byClipping
        label_d.font = UIFont.systemFont(ofSize: 18)
        label_d.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label_d.frame = CGRect.init(x: 10, y: 170, width: (view.frame.width - 20), height: 80)
        view.addSubview(label_l)
        view.addSubview(label_r)
        view.addSubview(label_d)
        return view
    }
    
    //forcast中的data
    func buildForcasInfo(day:Int) -> UIView{
        //scrollview的信息
        let widthV = self.view.frame.width
        //json forcast信息提取
        let day_info = self.cityInfo!["data"]["forecast"][day]
        //初始化view
        let view = UIView.init()
        view.frame = CGRect.init(x: 10, y: 600, width: widthV - 36, height: 240)
        view.backgroundColor = nil
        //初始化label左边
        let label_l = UILabel.init()
        label_l.numberOfLines = 0
        label_l.text = "日出:\t" + day_info["sunrise"].stringValue + "\n\n风向:\t" + day_info["fx"].stringValue +  "\n\n空气指数:\t" + day_info["aqi"].stringValue
        label_l.textAlignment = NSTextAlignment.left
        label_l.font = UIFont.systemFont(ofSize: 18)
        label_l.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label_l.frame = CGRect.init(x: 10, y: 10, width: (view.frame.width - 20) * 0.5 - 5, height: 120)
        //初始化label右边
        let label_r = UILabel.init()
        label_r.numberOfLines = 0
        label_r.text = "日落:\t" + day_info["sunset"].stringValue + "\n\n风力:\t" + day_info["fl"].stringValue + "\n\n"
        label_r.textAlignment = NSTextAlignment.left
        label_r.lineBreakMode = NSLineBreakMode.byClipping
        label_r.font = UIFont.systemFont(ofSize: 18)
        label_r.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        label_r.frame = CGRect.init(x: 15 + (view.frame.width - 20) * 0.5, y: 10, width: (view.frame.width - 20) * 0.5 - 10, height: 120)
        //初始化label底部
        let label_d = UILabel.init()
        label_d.numberOfLines = 0
        label_d.text =  day_info["notice"].stringValue + "\n" + day_info["ymd"].stringValue + "\t" + day_info["week"].stringValue
        label_d.textAlignment = NSTextAlignment.center
        label_d.lineBreakMode = NSLineBreakMode.byClipping
        label_d.font = UIFont.systemFont(ofSize: 18)
        label_d.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label_d.frame = CGRect.init(x: 10, y: 140, width: (view.frame.width - 20), height: 80)
        view.addSubview(label_l)
        view.addSubview(label_r)
        view.addSubview(label_d)
        return view
    }
    
    //数据更新时间
    func buildUpdateTime() -> UIView{
        //scrollview的信息
        let widthV = self.view.frame.width
        //初始化view
        let view = UIView.init()
        view.frame = CGRect.init(x: 10, y: 900, width: widthV - 36, height: 50)
        view.backgroundColor = nil
        //初始化label底部
        let label_d = UILabel.init()
        label_d.numberOfLines = 0
        label_d.text =  "数据更新时间：" + self.cityInfo!["cityInfo"]["updateTime"].stringValue
        label_d.textAlignment = NSTextAlignment.center
        label_d.lineBreakMode = NSLineBreakMode.byClipping
        label_d.font = UIFont.systemFont(ofSize: 18)
        label_d.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label_d.frame = CGRect.init(x: 10, y: 10, width: (view.frame.width - 20), height: 40)
        view.addSubview(label_d)
        return view
    }
}
