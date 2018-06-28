//
//  ViewController.swift
//  bankStoreMIni
//
//  Created by 최 봉식 on 2018. 6. 19..
//  Copyright © 2018년 jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
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
    }
    
    // MARK: - table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifierTableViewCell", for: indexPath) as! StoreListTableViewCell
        let cellData = self.arrListModel[indexPath.row]
        cell.lblTitle.text = "\(cellData.name!)"
        cell.lblSubTitle.text = "\(cellData.id!)"
        cell.lblNum.text = "\(indexPath.row + 1)"
        if let imgURL = URL(string: cellData.image!) {
            NetworkManager.sharedManager.getImage(url: imgURL)
            {
                (data, error) in
                cell.imgLogo.image = UIImage(data: data!)
            }
        }
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = self.arrListModel[indexPath.row]
        let viewController: DetailTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
        viewController.cellData = cellData
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
