//
//  WeatherViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/25.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,PickerDelegate {
    
    private var cityList : NSMutableDictionary = [:]
    
    //选中地址
    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
        let messge = area.region_name!
        print(messge)
    }
    
    func selectedDate(_ pickerView: BHJPickerView, _ dateStr: Date) {
        print("")
    }
    
    func selectedGender(_ pickerView: BHJPickerView, _ genderStr: String) {
        print("")
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置背景和毛玻璃
        let bg_view : UIView = UIView.init(frame: self.view.frame)
        let bg_image : UIImage = UIImage.init(imageLiteralResourceName: "天气-bg1")
        let bg_imageView : UIImageView = UIImageView.init(image: bg_image)
        bg_imageView.frame = bg_view.frame
        bg_view.addSubview(bg_imageView)
        let toolbar : UIToolbar = UIToolbar.init(frame: bg_view.frame)
        bg_view.addSubview(toolbar)
        self.view.addSubview(bg_view)
        self.view.sendSubviewToBack(bg_view)
        //设置tableview
        tableView.backgroundColor = nil
        tableView.sectionIndexBackgroundColor = nil
        tableView.register(weatherCityCell.classForCoder(), forCellReuseIdentifier: cellID)
        //初始化数据库
        let db = sqlitedb.init()
        db.getCity_code(city_name: "北京")
    }
    
    // MARK: - tableViewDelegate
    //每个section中的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    //城市cellID
    let cellID:String = "weatherCityCell"
    
    //设置cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //创建cell
        var cell : weatherCityCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! weatherCityCell
        cell = cell.weatherCity()
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.contentView.backgroundColor = nil
        cell.backgroundColor = nil
        return cell
    }
    
    //页脚
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //页脚view
        let footView : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        footView.backgroundColor = nil
        //添加城市
        let button : UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("点此添加城市", for: UIControl.State.normal)
        button.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        button.setTitleColor(UIColor.blue, for: UIControl.State.highlighted)
        button.frame = CGRect.init(x: (tableView.frame.size.width - 150)/2, y: 0, width: 150, height: 20)
        button.addTarget(self, action:#selector(addCity(sender:)), for: UIControl.Event.touchUpInside)
        //添加到footview中
        footView.addSubview(button)
        return footView
    }
    
    //添加城市
     @objc func addCity(sender: UIButton?){
        let pickerView = BHJPickerView.init(self, .address)
        pickerView.pickerViewShow()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
