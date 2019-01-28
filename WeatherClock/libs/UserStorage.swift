//
//  UserStorage.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/26.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

//用户数据存储类
class UserStorage: NSObject {
    //存储用户数据
    func setNormalDefault(key:String, value:AnyObject?){
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        }
        else{
            UserDefaults.standard.set(value, forKey: key)
            // 同步
            UserDefaults.standard.synchronize()
        }
    }
    
    /**
     通过key找到储存的value
     
     - parameter key: key
     
     - returns: AnyObject
     */
    func getNormalDefult(key:String)->AnyObject?{
        return UserDefaults.standard.value(forKey: key) as AnyObject
    }
    
    /**
     通过对应的key移除储存
     
     - parameter key: 对应key
     */
    func removeNormalUserDefault(key:String?){
        if key != nil {
            UserDefaults.standard.removeObject(forKey: key!)
            UserDefaults.standard.synchronize()
        }
    }
    
}
