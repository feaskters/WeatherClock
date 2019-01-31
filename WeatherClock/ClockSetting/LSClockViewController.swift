//
//  LSClockViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/29.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class LSClockViewController: UIViewController {
    
    var minLayer:CALayer = CALayer.init()
    var houLayer:CALayer = CALayer.init()
    var secLayer:CALayer = CALayer.init()
    var anLayer:CALayer = CALayer.init()
    var morning:UILabel = UILabel.init()
    let clock :UIImageView = UIImageView.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置背景
        let image = UIImage.init(named: "时钟页面背景")
        let imageView_bg = UIImageView.init(image: image)
        imageView_bg.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(imageView_bg)
        self.view.sendSubviewToBack(imageView_bg)
        
        self.view.addSubview(setDate())
        self.view.addSubview(setClock())
        self.setMorning()
        self.view.addSubview(self.morning)
        
        self.clock.layer.addSublayer(self.houLayer)
        self.clock.layer.addSublayer(self.minLayer)
        self.clock.layer.addSublayer(self.secLayer)
        self.clock.layer.addSublayer(self.anLayer)
        
        //定时器旋转
        Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(rotatePoint) , userInfo: nil, repeats: true)
        self.rotatePoint()
    }
    
    //旋转
    @objc func rotatePoint() {
        //获取当前时间
        let calender = Calendar.current
        let cmp = calender.dateComponents([Calendar.Component.second,Calendar.Component.minute,Calendar.Component.hour], from: Date.init())
        
        //秒针旋转
        let sec = CGFloat(cmp.second!)
        let anger:CGFloat = (sec * 6) / 180 * CGFloat(Double.pi)
        self.secLayer.transform = CATransform3DMakeRotation(anger, 0, 0, 1)
        
        //分针旋转
        let min = CGFloat(cmp.minute!)
        let anger_min :CGFloat = (min * 6) / 180 * CGFloat(Double.pi)
        self.minLayer.transform = CATransform3DMakeRotation(anger_min, 0, 0, 1)
        
        //时针旋转
        let hour = CGFloat(cmp.hour!)
        let anger_hour :CGFloat = (hour * 30 + min * 0.5) / 180 * CGFloat(Double.pi)
        self.houLayer.transform = CATransform3DMakeRotation(anger_hour, 0, 0, 1)
        
        //设置am和pmlabel
        if cmp.hour! >= 12 {
            self.morning.text = "PM"
        }else{
            self.morning.text = "AM"
        }
    }
    
    //设置日期
    func setDate() -> UIView{
        
        //页面宽高
        let screen_w = self.view.frame.width
        //设置日期表盘
        let dateView = UIView.init()
        dateView.frame = CGRect.init(x: 20, y: 100, width: screen_w - 40, height: 150)
        let image_date_bg = UIImage.init(named: "日期背景")
        let imageView_date_bg = UIImageView.init(image: image_date_bg)
        imageView_date_bg.frame = CGRect.init(x: 0, y: 0, width: dateView.frame.width, height: dateView.frame.height)
        dateView.addSubview(imageView_date_bg)
        //设置日期翻页
        let image_date_fy = UIImage.init(named: "日期翻页")
        let imageView_date_fy1 = UIImageView.init(image: image_date_fy)
        let imageView_date_fy2 = UIImageView.init(image: image_date_fy)
        let imageView_date_fy3 = UIImageView.init(image: image_date_fy)
        let date_fy_y:CGFloat = 30
        let space:CGFloat = 20
        let date_fy_height:CGFloat = dateView.frame.height - 2 * date_fy_y
        let date_fy_width:CGFloat = (dateView.frame.width - 80) / 4
        imageView_date_fy1.frame = CGRect.init(x: space, y: date_fy_y, width: date_fy_width * 2, height: date_fy_height)
        imageView_date_fy2.frame = CGRect.init(x: space * 2 + date_fy_width * 2, y: date_fy_y, width: date_fy_width, height: date_fy_height)
        imageView_date_fy3.frame = CGRect.init(x: space * 3 + date_fy_width * 3, y: date_fy_y, width: date_fy_width, height: date_fy_height)
        dateView.addSubview(imageView_date_fy1)
        dateView.addSubview(imageView_date_fy2)
        dateView.addSubview(imageView_date_fy3)
        //设置日期翻页中的日期
        let date = Date.init()
        let format = DateFormatter.init()
        format.dateFormat = "yyyy"
        let year = format.string(from: date)
        format.dateFormat = "MM"
        let month = format.string(from: date)
        format.dateFormat = "dd"
        let day = format.string(from: date)
        let label_year = UILabel.init(frame: imageView_date_fy1.frame)
        label_year.font = UIFont.systemFont(ofSize: 42)
        label_year.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        label_year.text = year
        label_year.textAlignment = NSTextAlignment.center
        let label_month = UILabel.init(frame: imageView_date_fy2.frame)
        label_month.font = UIFont.systemFont(ofSize: 42)
        label_month.textAlignment = NSTextAlignment.center
        label_month.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        label_month.text = month
        let label_day = UILabel.init(frame: imageView_date_fy3.frame)
        label_day.font = UIFont.systemFont(ofSize: 42)
        label_day.textAlignment = NSTextAlignment.center
        label_day.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        label_day.text = day
        dateView.addSubview(label_year)
        dateView.addSubview(label_month)
        dateView.addSubview(label_day)
        return dateView
    }
    
    //设置时钟
    func setClock() -> UIView{
        let view = UIView.init()
        view.frame = CGRect.init(x: (self.view.frame.width - 250) * 0.5, y: 300, width: 250, height: 250)
        //添加表盘
        let image = UIImage.init(named: "表盘")
        self.clock.image = image
        self.clock.frame = CGRect.init(x: 0, y: 0, width: 250, height: 250)
        view.addSubview(self.clock)
        //设置指针
        self.setSecond()
        self.setMinute()
        self.setHour()
        self.setCenter()
        return view
    }
    
    //设置秒针
    func setSecond(){
        let second:CALayer = CALayer.init()
        let image = UIImage.init(named: "秒针")
        second.bounds = CGRect.init(x: 0, y: 0, width: 22, height: 127)
        second.contents = image?.cgImage
        second.anchorPoint = CGPoint.init(x: 0.5, y: 0.92)
        second.position = CGPoint.init(x: self.clock.frame.width * 0.5, y: self.clock.frame.height * 0.5)
        self.secLayer = second
    }
    //设置分针
    func setMinute(){
        let minute:CALayer = CALayer.init()
        let image = UIImage.init(named: "分针")
        minute.bounds = CGRect.init(x: 0, y: 0, width: 27, height: 112)
        minute.contents = image?.cgImage
        minute.anchorPoint = CGPoint.init(x: 0.5, y: 0.9)
        minute.position = CGPoint.init(x: self.clock.frame.width * 0.5, y: self.clock.frame.height * 0.5)
        self.minLayer = minute
    }
    //设置时针
    func setHour(){
        let hour:CALayer = CALayer.init()
        let image = UIImage.init(named: "时针")
        hour.bounds = CGRect.init(x: 0, y: 0, width: 44, height: 107)
        hour.contents = image?.cgImage
        hour.anchorPoint = CGPoint.init(x: 0.5, y: 0.92)
        hour.position = CGPoint.init(x: self.clock.frame.width * 0.5, y: self.clock.frame.height * 0.5)
        self.houLayer = hour
    }
    //设置中心锚点
    func setCenter(){
        let an:CALayer = CALayer.init()
        an.bounds = CGRect.init(x: 0, y: 0, width: 10, height: 10)
        an.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        an.cornerRadius = 5
        an.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.7529411765, blue: 0, alpha: 1)
        an.position = CGPoint.init(x: self.clock.frame.width * 0.5, y: self.clock.frame.height * 0.5)
        self.anLayer = an
    }
    //设置morninglabel
    func setMorning(){
        let label = UILabel.init()
        label.frame = CGRect.init(x: (self.view.frame.width - 200) * 0.5, y: 570, width: 200, height: 50)
        label.text = "AM"
        label.textColor = #colorLiteral(red: 0.9105771623, green: 0.8279893191, blue: 0.1446023505, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 32)
        self.morning = label
    }
}
