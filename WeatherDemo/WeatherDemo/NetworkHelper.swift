//
//  NetworkHelper.swift
//  WeatherDemo
//
//  Created by xjc on 16/5/24.
//  Copyright © 2016年 xjc. All rights reserved.
//

import Just

enum NetworkHelper {
    case WeeklyWeather(cityid: String)
    
    // hsttp://api.k780.com:88/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json
    static var params = [
        "app" : "weather.future",
        "appkey" : "10003",
        "sign" : "b59bc3ef6191eb9f747dd4e83c99f2a4",
        "format" : "json"
    ]
    
    static let baseUrl = "http://api.k780.com:88"
    
    func getWeather(compeltion: ([Result]?,String?) -> Void) {
        
        var error:String?
        var results: [Result]?
        
        switch self {
        case .WeeklyWeather(cityid: let weaid):
            
            NetworkHelper.params["weaid"] = weaid
            
            Just.get(NetworkHelper.baseUrl, params: NetworkHelper.params, asyncCompletionHandler: { (r) -> Void in
                if r.ok {
                    //取保返回结果是一个json，并转换为一个字典
                    guard let jsonDict = r.json as? NSDictionary else {
                        error = "不是一个json字符串"
                        return
                    }
                    //确保字典中的success字段的值是1
                    guard let success = jsonDict["success"] where success as? String == "1" else {
                        error = "返回数据格式不对，或者授权错误"
                        return
                    }
                    
                    let weather = Weather.init(fromDictionary: jsonDict)
                    results = weather.result
                    
                } else {
                    error = "服务器出错"
                }
                
                compeltion(results, error)
            })
        }
    }
}