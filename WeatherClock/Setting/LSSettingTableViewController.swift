//
//  LSSettingTableViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/30.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit
import UserNotifications

class LSSettingTableViewController: UITableViewController {

    //存储key
    private let key = "citys"
    @IBOutlet weak var clearDataOfCity: UITableViewCell!
    @IBOutlet weak var notificationSetting: UITableViewCell!
    @IBOutlet weak var notificationCheck: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
       
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //清空城市缓存
        if indexPath.section == 1 && indexPath.row == 0 {
            clearCity()
        }
        //清空推送缓存
        if indexPath.section == 1 && indexPath.row == 1 {
            clearNotification()
        }
    }
    
    //清空推送缓存
    func clearNotification() {
        //弹出警告框
        let alert = UIAlertController.init(title: "系统提示", message: "清空缓存后所有消息推送会被清除,确认要清空推送缓存？", preferredStyle: UIAlertController.Style.alert)
        let action_cancel = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let action_delete = UIAlertAction.init(title: "清空", style: UIAlertAction.Style.destructive, handler:{
            action in
            //清除缓存
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        })
        alert.addAction(action_cancel)
        alert.addAction(action_delete)
        self.present(alert, animated: true, completion: nil)
    }
    
    //清空城市缓存
    func clearCity() {
        //弹出警告框
        let alert = UIAlertController.init(title: "系统提示", message: "清空缓存后所选择城市会被清除,确认要清空城市缓存？", preferredStyle: UIAlertController.Style.alert)
        let action_cancel = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let action_delete = UIAlertAction.init(title: "清空", style: UIAlertAction.Style.destructive, handler:{
            action in
            //清除缓存
            let us = UserStorage.init()
            us.removeNormalUserDefault(key: self.key)
        })
        alert.addAction(action_cancel)
        alert.addAction(action_delete)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
