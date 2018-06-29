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
        
        NetworkManager.sharedManager.getStoreData(url: URL(string: "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json")!)
        {
            (resultDic, error) in
            if let feedData:Dictionary = resultDic!["feed"] as? Dictionary<String,Any> {
                if let entryData:Array = feedData["entry"] as? Array<Dictionary<String,Any>> {
                    self.arrListModel = entryData.map{ item -> ListModel in
                        return ListModel.init(name: NetworkManager.sharedManager.getName(name: item["im:name"] as! Dictionary<String, Any>),
                                              image: NetworkManager.sharedManager.getImage(image: item["im:image"] as! Array<Dictionary<String,Any>>),
                                              trackId: NetworkManager.sharedManager.getId(id: item["id"] as! Dictionary<String, Any>))
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
        cell.lblNum.text = "\(indexPath.row + 1)"
        cell.imgLogo.loadImageUsingCache(withUrl: cellData.image!)
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = self.arrListModel[indexPath.row]
        
        if cellData.trackId != 0 {
            NetworkManager.sharedManager.getStoreData(url: URL(string: "https://itunes.apple.com/lookup?id=\(String(cellData.trackId!))&country=kr")!)
            {
                (resultDic, error) in
                let result = resultDic!["results"] as! Array<Dictionary<String,Any>>

                let viewController: DetailTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
                viewController.rank = indexPath.row+1
                viewController.detailModel = DetailModel(fromDictionary: result.first!)
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}
