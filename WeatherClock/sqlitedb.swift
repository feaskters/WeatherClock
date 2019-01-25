//
//  sqlitedb.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/1/25.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import Foundation
import SQLite3

class sqlitedb {
    
    //不透明指针，对应C语言中的void *,这里指sqlit3指针
    private var db:OpaquePointer? = nil
    
    //初始化方法打开数据库
    required init() {
        print(Bundle.main.path(forResource: "citys", ofType: "db")!)
        
        //String类的路径，转换成cString
        let cpath = Bundle.main.path(forResource: "citys", ofType: "db")!.cString(using: .utf8)

        //打开数据库
        let error = sqlite3_open(cpath!,&db)

        //数据库打开失败
        if  error != SQLITE_OK {
            sqlite3_close(db)
        }
    }
    //关闭数据库
    deinit {
        self.closeDB()
    }
    func closeDB() -> Void {
        sqlite3_close(db)
    }
    //查询
    func getCity_code(city_name:String?) -> String {
        let sql = "select city_code from citys where city_name = \'" + city_name! + "\'"
        //sqlite3_stmt指针
        var stmt:OpaquePointer? = nil
        let cSql = sql.cString(using: .utf8)
        
        //编译
        let prepare_result = sqlite3_prepare_v2(self.db, cSql!, -1, &stmt, nil)
        if prepare_result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if (sqlite3_errmsg(self.db)) != nil {
                let msg = "SQLiteDB - failed to prepare SQL:\(sql)"
                print(msg)
            }
        }
        
        var res :String = ""
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let str = UnsafePointer(sqlite3_column_text(stmt, 0))
            let str2 = String.init(cString: str!)
            res = str2
        }
        return res
    }
}
