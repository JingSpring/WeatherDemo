//
//  WeatherTableViewController.swift
//  WeatherDemo
//
//  Created by xjc on 16/5/25.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    var sectionTitles = ["","一周天气预报","天气简报","其他数据"]
    
    var results:[Result] = []
    
    var result:[Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellnib = UINib(nibName: "HeaderCell", bundle: nil)
        self.tableView.registerNib(cellnib, forCellReuseIdentifier: "headerCell")
        
        let weeknib = UINib(nibName: "WeekCell", bundle: nil)
        self.tableView.registerNib(weeknib, forCellReuseIdentifier: "weekCell")
        
        let briefnib = UINib(nibName: "BriefCell", bundle: nil)
        self.tableView.registerNib(briefnib, forCellReuseIdentifier: "briefCell")
        
        let attachnib = UINib(nibName: "AttachCell", bundle: nil)
        self.tableView.registerNib(attachnib, forCellReuseIdentifier: "attachCell")
        
        //北京的天气预报
        let weeklyWeather = NetworkHelper.WeeklyWeather(cityid: "1")
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false 
        
        weeklyWeather.getWeather { (results, error) -> Void in
            if let results = results {
                
                self.results = results
                self.result.append(results.first!)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                })
                
            } else {
                let alertVC = UIAlertController(title: "网络错误", message: error!, preferredStyle: .Alert)
                let action = UIAlertAction(title: "好", style: .Default, handler: nil)
                alertVC.addAction(action)
                self.presentViewController(alertVC, animated: true, completion: { () -> Void in
                    
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return results.count
        default:
            return result.count
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 3:
            return 88
        default:
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellID = ""
        let weather = result[0]
        
        switch indexPath.section {
        case 0:
            cellID = "headerCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! HeaderCell
            cell.labelCity.text = weather.citynm
            cell.labelTemp.text = weather.tempHigh + "°"
            cell.labelWeather.text = weather.weather
            
            return cell
        case 1:
            cellID = "weekCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! WeekCell
            
            let result = results[indexPath.row]
            
            if indexPath.row == 0 {
                cell.labelToday.text = "今天"
            } else {
                cell.labelToday.text = "  "
            }
            
            cell.labelWeek.text = result.week
            
            let data = NSData(contentsOfURL: NSURL(string: result.weatherIcon)!)!
            cell.imgWeatherIcon.image = UIImage(data: data)
            
            cell.labelHTemp.text = result.tempHigh
            cell.labelLTemp.text = result.tempLow
            
            return cell
        case 2:
            cellID = "briefCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BriefCell
            cell.labelBrief.text = "\(weather.weather).最高温\(weather.tempHigh),最低温\(weather.tempLow)."
            return cell
        case 3:
            cellID = "attachCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! AttachCell
            cell.labelTemp.text = weather.wind   //湿度
            cell.labelHumid.text = weather.humidity
            return cell
        default:
            return UITableViewCell(frame: CGRectZero)
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
