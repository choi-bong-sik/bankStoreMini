//
//  ViewController.swift
//  bankStoreMIni
//
//  Created by 최 봉식 on 2018. 6. 19..
//  Copyright © 2018년 jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var table:UITableView!
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    var arrListModel:Array<ListModel> = Array()
    
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
                    self.arrListModel = entryData.map{ item -> ListModel in
                        return ListModel.init(name: NetworkManager.sharedManager.getName(name: item["im:name"] as! Dictionary<String, Any>),
                                              image: NetworkManager.sharedManager.getImage(image: item["im:image"] as! Array<Dictionary<String,Any>>),
                                              id: NetworkManager.sharedManager.getId(id: item["id"] as! Dictionary<String, Any>))
                    }
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }
            }
        }
        NetworkManager.sharedManager.getImage(url: URL(string:"https://is1-ssl.mzstatic.com/image/thumb/Purple115/v4/51/31/34/513134c5-f179-0223-7278-7f477500d1c2/AppIcon-1x_U007emarketing-85-220-0-6.png/53x53bb-85.png")!) { (data, error) in
            self.imageView.image = UIImage(data: data!)
        }
    }
    
    // MARK: - table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifierTableViewCell", for: indexPath) as! TableViewCell
        let cellData = self.arrListModel[indexPath.row]
        cell.lblTitle.text = "\(cellData.name!)"
        cell.lblSubTitle.text = "\(cellData.id!)"
        cell.lblNum.text = "\(indexPath.row + 1)"
        NetworkManager.sharedManager.getImage(url: URL(string: cellData.image!)!) { (data, error) in
            cell.imgLogo.image = UIImage(data: data!)
        }
        return cell;
    }
}
