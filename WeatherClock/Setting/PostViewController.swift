//
//  PostViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/31.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class PostViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    //存储key
    private let key = "citys"
    @IBOutlet weak var cityPickerView: UIPickerView!
    //城市信息列表
    var cityList :NSArray = []
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let json = JSON.init(parseJSON: self.cityList[row] as! String)
        return json["cityInfo"]["city"].stringValue
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cityList.count
    }
    

    @IBOutlet weak var cityPicker: UIPickerView!
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
        //从userstorage获取数据
        self.getCityInfo()
    }
    
    //从userstorage获取数据
    func getCityInfo() {
        let us = UserStorage.init()
        //从用户数据中读取citys
        let tem = us.getNormalDefult(key: key)!
        if tem.count! == 0 {
            print("数据为空")
            let alert = UIAlertController.init(title: "系统提示", message: "请先在天气页面添加城市", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true) {
                
            }
        }else
        {
            self.cityList = NSArray.init(array: tem as! [Any])
        }
    }
    
    @IBAction func `continue`(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTimePicker" {
            let tpvc:TimePickerViewController = segue.destination as! TimePickerViewController
            tpvc.cityInfo = JSON.init(parseJSON:  self.cityList[cityPickerView.selectedRow(inComponent: 0)] as! String)
        }
    }
}
