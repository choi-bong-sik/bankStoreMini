//
//  NetworkManager.swift
//  bankStoreMIni
//
//  Created by 앱개발팀 on 2018. 6. 24..
//  Copyright © 2018년 jake. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
    static let sharedManager = NetworkManager()
    private override init() {
        
    }
    
    func getAppStoreList(url:URL, completionHandler: @escaping ([String: Any]?, Error?) -> Swift.Void){
        if dataTask != nil {
            dataTask?.cancel()
        }
        dataTask = defaultSession.dataTask(with: URLRequest.init(url: url), completionHandler:
            {
                (data, response, error) in
                
                if let error = error {
                    completionHandler(nil, error)
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        guard let resultDic = self.convertServerResponseData(responseData: data) else {
                            return
                        }
                        completionHandler(resultDic, error)
                    }
                }
                
        })
        dataTask?.resume()
    }
    
    func getImage (url:URL, completionHandler: @escaping (Data?, Error?) -> Swift.Void){
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!)
                completionHandler(nil,error)
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(data,error)
            }
        }).resume()
    }
    
    func convertServerResponseData(responseData: Data!) -> [String: Any]?{
        guard let responseDataStr: String = String(data:responseData , encoding: .utf8) else {
            // 디코딩 실패
            return ["Result":"R310"]
        }
        guard let resultDic = self.convertToDictionary(text: responseDataStr) else {
            // json실패
            return ["Result":"R311"]
        }
        return resultDic
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print("convertToDictionary Error : \(error.localizedDescription)")
            }
        }
        return nil
    }
    func getId(id:Dictionary<String,Any>) -> Int {
        if let attributes =  id["attributes"] as? Dictionary<String, Any> {
            if let imId = attributes["im:id"] {
                return Int(imId as! String)!
            }
            return 0
        }
        return 0
    }
    func getName(name:Dictionary<String,Any>) -> String {
        if let label = name["label"] as? String {
            return label
        }
        return ""
    }
    func getImage(image:Array<Dictionary<String,Any>>) -> String{
        if let label = image.last!["label"] as? String {
            return label
        }
        return ""
    }
}
