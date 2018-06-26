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
    
    func getAppStoreList(url:URL, completionHandler: @escaping ([String: Any]?, URLResponse?, Error?) -> Swift.Void){
        if dataTask != nil {
            dataTask?.cancel()
        }
        dataTask = defaultSession.dataTask(with: URLRequest.init(url: url), completionHandler:
            {
                (data, response, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(nil, response, error)
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        guard let resultDic = self.convertServerResponseData(responseData: data) else {
                            return
                        }
                        print(resultDic)
                        completionHandler(resultDic, response, error)
                    }
                }
                
        })
        dataTask?.resume()
    }
    
    func convertServerResponseData(responseData: Data!) -> [String: Any]?{
        guard let responseDataStr: String = String(data:responseData , encoding: .utf8) else {
            // 디코딩 실패
            return ["Result":"R310"]
        }
        guard let resultDic = self.convertToDictionary(text: responseDataStr) else {
            // json실
            return ["Result":"R311"]
        }
        print(resultDic)
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
}
