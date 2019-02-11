//
//  LSPostTableViewController.swift
//  WeatherClock
//
//  Created by iOS123 on 2019/2/11.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit
import UserNotifications
class LSPostTableViewController: UITableViewController {
    
    var notifications : [UNNotificationRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            self.notifications = requests
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.notifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pushCell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        cell.textLabel?.text = notifications[indexPath.row].identifier
        return cell
    }

    //取消当前推送
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController.init(title: "注意", message: "是否确认删除该推送？", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "否", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            
        }))
        alert.addAction(UIAlertAction.init(title: "是", style: UIAlertAction.Style.destructive, handler: { (UIAlertAction) in
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.notifications[indexPath.row].identifier])
            self.notifications.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.middle)
        }))
       
        self.present(alert, animated: true) {}
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
