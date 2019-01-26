//
//  WeatherViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/25.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,PickerDelegate {
    
    //数据库
    private var db = sqlitedb.init()
    //城市列表
    private var cityList : NSMutableArray = []
    //存储key
    private let key = "citys"
    //初始化用户数据库
    let us  = UserStorage.init()
    //选中地址
    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
        var code :String = ""
        if area.region_name != nil{
            code = area.agency_id!
        }else{
            code = city.agency_id!
        }
        //从接口获取json数据
        let info = getDataFromUrl(city_code: code)
        //城市json信息
        cityList.add(info.stringValue)
        //保存到用户数据中
        //先转为二进制数据
        us.setNormalDefault(key: key, value: cityList)
        //刷新tableview
        self.tableView.insertRows(at: [IndexPath.init(row: cityList.count - 1, section: 0)], with: UITableView.RowAnimation.fade)
        
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
        //从用户数据中读取citys
            let tem = us.getNormalDefult(key: key)
       
        
        print(tem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // MARK: - tableViewDelegate
    //每个section中的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    //城市cellID
    let cellID:String = "weatherCityCell"
    
    //设置cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //创建cell
        var cell : weatherCityCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! weatherCityCell
        cell.contentView.backgroundColor = nil
        cell = cell.weatherCity()
        print(self.cityList[indexPath.row])
        cell.info = JSON.init(parseJSON: self.cityList[indexPath.row] as! String)
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
    
    //从接口获取数据
    func getDataFromUrl(city_code:String!) -> JSON{
        let path = "http://t.weather.sojson.com/api/weather/city/" + city_code
        let url = URL.init(string: path)
        do {
            let data = try NSData(contentsOf: url!, options: NSData.ReadingOptions.alwaysMapped)
            let json = try JSON(data: data as Data)
            return json
        } catch {
            return JSON.init("")
        }
    }
    //MARK: - tableViewDataSource
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        cityList.removeObject(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.middle)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
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
