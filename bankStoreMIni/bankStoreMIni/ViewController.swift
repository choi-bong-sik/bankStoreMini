//
//  ViewController.swift
//  bankStoreMIni
//
//  Created by 최 봉식 on 2018. 6. 19..
//  Copyright © 2018년 jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
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
        NetworkManager.sharedManager.getAppStoreList(url: URL(string: "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json")!)
        {
            (resultDic, error) in
            if let feedData:Dictionary = resultDic!["feed"] as? Dictionary<String,Any> {
                if let entryData:Array = feedData["entry"] as? Array<Dictionary<String,Any>> {
                    print(entryData.first!)
                }
            }
        }
        NetworkManager.sharedManager.getImage(url: URL(string:"https://is1-ssl.mzstatic.com/image/thumb/Purple115/v4/51/31/34/513134c5-f179-0223-7278-7f477500d1c2/AppIcon-1x_U007emarketing-85-220-0-6.png/53x53bb-85.png")!) { (data, error) in
            self.imageView.image = UIImage(data: data!)
        }
    }
    
    func getAppStoreList(){
        if dataTask != nil {
            dataTask?.cancel()
        }
        let url = URL(string: "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json")
        dataTask = defaultSession.dataTask(with: URLRequest.init(url: url!), completionHandler:
            {
                (data, response, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        guard let resultDic = self.convertServerResponseData(responseData: data) else {
                            return
                        }
                        print(resultDic)
                    }
                }
                
        })
        dataTask?.resume()
    }
    
    func getList()
    {
        SessionManager.default.request("https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json").responseData
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
                    print(resultDic)
                    break
                case .failure(let error):
                    print(error)
                    break
                }
        }
    }
    
    func getDetail(appId : String){
        SessionManager.default.request("https://itunes.apple.com/lookup?id=\(appId)&country=kr").responseData
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
                    print(resultDic)
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
