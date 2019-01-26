# WeatherClock
IOS项目-天气时钟
## 功能介绍
- 类似天气预报的功能，添加所在城市并通过接口获取近七天的天气信息
- 添加时钟提醒功能，设置时间后，每日在设置的时间会推送今日天气状况
## 所学技术
1. swift语法回顾
2. tableView 中cell左滑删除功能
3. tableview 中页眉与页脚的使用
4. swift 原生sqlite3使用
5. 从api接口获取data数据并转为json
    - <font color=gray size=10>注意：</font>
      1. 需要在info.plist中添加App Transport Security Settings选项
      2. 在App Transport Security Settings中设置Allow Arbitrary Loads为YES
    - 否则通过http协议读取到的数据为空
6. tableView操作cell时:
    - 使用```swift tableView.insertRows(at: [IndexPath], with: UITableView.RowAnimation)```来动态添加cell
    - 使用```swift  tableView.deleteRows(at: [IndexPath], with: UITableView.RowAnimation)```来动态删除cell
    - 使用```swift  tableView.reloadRows(at: [IndexPath], with: UITableView.RowAnimation)```来局部刷新cell
    - 使用```swift tableView.reloadData() ```来刷新整个tableview的数据
## 所用资源
1. 来自[爱给网](http://www.aigei.com/)的图片和图标
2. 来自[站长素材](http://sc.chinaz.com/yinxiao/)的音效
