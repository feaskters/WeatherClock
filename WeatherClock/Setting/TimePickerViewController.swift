//
//  TimePickerViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/31.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit
import UserNotifications

class TimePickerViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    var cityInfo:JSON = JSON("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置毛玻璃效果
        let image = UIImage.init(named: "推送背景")
        let imageview_bg = UIImageView.init(image: image)
        imageview_bg.frame = self.view.frame
        let toolbar = UIToolbar.init()
        toolbar.frame = self.view.frame
        toolbar.alpha = 0.95
        let bg_view = UIView.init(frame: self.view.frame)
        bg_view.addSubview(imageview_bg)
        bg_view.addSubview(toolbar)
        self.view.addSubview(bg_view)
        self.view.sendSubviewToBack(bg_view)
        // Do any additional setup after loading the view.
        self.cityName.text = self.cityInfo["cityInfo"]["city"].stringValue
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func complete(_ sender: UIButton) {
        //格式化推送时间
        let date = self.timePicker.date
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        let interval:TimeInterval = 24*60*60
        let tommorrow = date.addingTimeInterval(interval)
        let pushTime = dateFormatter.string(from: tommorrow)
        //推送提示
        let alert = UIAlertController.init(title: "提示", message: "系统将在-" + pushTime + "-为您推送-" + self.cityName.text! + "-的天气信息，是否确定?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            //设置推送
            //设置推送内容
            let notificationContent = UNMutableNotificationContent.init()
            let content = self.cityInfo["data"]["forecast"][1]["low"].stringValue + "->" + self.cityInfo["data"]["forecast"][1]["high"].stringValue + "\n" + self.cityInfo["data"]["forecast"][1]["notice"].stringValue
            notificationContent.body = content
            notificationContent.title = self.cityName.text!
            notificationContent.subtitle = self.cityInfo["data"]["forecast"][1]["type"].stringValue
            //设置推送时间
            let calendar = Calendar.current
            var component = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: tommorrow)
            component.setValue(0, for: Calendar.Component.second)
            //推送请求
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: component, repeats: false)
            let request = UNNotificationRequest.init(identifier: self.cityInfo["cityInfo"]["city"].stringValue + "  " + pushTime, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (Error) in
                print(Error as Any)
            }
                self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
