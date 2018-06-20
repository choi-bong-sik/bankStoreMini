//
//  ViewController.swift
//  bankStoreMIni
//
//  Created by 최 봉식 on 2018. 6. 19..
//  Copyright © 2018년 jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
         https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/
         https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json
         https://itunes.apple.com/lookup?id={id}&country=kr
         https://itunes.apple.com/lookup?id=839333328&country=kr
         //839333328
         */
        self.getDetail(appId: "839333328")
    }
    
    func getList()
    {
        AlamofireAppManager.shared.request("https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json").responseData
            {
                [weak self] responseData in
                guard let `self` = self else { return }
                
                print(responseData.debugDescription)
                dump(responseData.result)
                switch responseData.result {
                case .success(let data):
                    print(data)
                    
                    guard let resultDic = self.convertServerResponseData(responseData: data) else {
                        return
                    }
                    
                    break
                case .failure(let error):
                    print(error)
                    break
                }
        }
    }
    
    func getDetail(appId : String){
        AlamofireAppManager.shared.request("https://itunes.apple.com/lookup?id=\(appId)&country=kr").responseData
            {
                [weak self] responseData in
                guard let `self` = self else { return }
                
                print(responseData.debugDescription)
                dump(responseData.result)
                
                switch responseData.result {
                case .success(let data):
                    print(data)
                    
                    guard let resultDic = self.convertServerResponseData(responseData: data) else {
                        return
                    }
                    
                    break
                case .failure(let error):
                    print(error)
                    break
                }
        }
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


struct AlamofireAppManager {
    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        
        let sessionManager = SessionManager(configuration: configuration)
        return sessionManager
    }()
}
