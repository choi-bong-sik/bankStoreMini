//
//  DetailTableViewController.swift
//  bankStoreMIni
//
//  Created by 최 봉식 on 2018. 6. 28..
//  Copyright © 2018년 jake. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var detailModel:DetailModel?
    var rank:Int?
    
    @IBOutlet weak var imgLogo:UIImageView!
    @IBOutlet weak var lblTrackName:UILabel!
    @IBOutlet weak var lblUserRatingCount:UILabel!
    @IBOutlet weak var lblRank:UILabel!
    @IBOutlet weak var lblTrackContentRating:UILabel!
    @IBOutlet weak var lblVersion:UILabel!
    @IBOutlet weak var lblVersionReleaseDate:UILabel!
    @IBOutlet weak var tfReleaseNotes:UITextView!
    @IBOutlet weak var scrScreenShot:UIScrollView!
    @IBOutlet weak var tfDescription:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = detailModel?.artistName!
        if let artworkUrl = detailModel?.artworkUrl100 {
            self.imgLogo.loadImageUsingCache(withUrl:artworkUrl)
        }
        self.lblTrackName.text = detailModel?.artistName!
        self.lblUserRatingCount.text = "평가 \(detailModel?.averageUserRating ?? 0)"
        self.lblTrackContentRating.text = detailModel?.trackContentRating
        self.lblRank.text = "#\(rank!)"
        if let strVersion:String = detailModel?.version {
            self.lblVersion.text = "버전 \(strVersion)"
        }
        self.lblVersionReleaseDate.text = detailModel?.currentVersionReleaseDate!
        self.tfReleaseNotes.text = detailModel?.releaseNotes
        
        if (detailModel?.screenshotUrls.count)! > 0 {
            self.drawScreenShots(imageUrls: (detailModel?.screenshotUrls)!, scrollView: scrScreenShot)
        }
        self.tfDescription.text = detailModel?.descriptionField
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 2
        default:
            return 0
        }
    }
    
    // MARK: - DrawObject
    func drawScreenShots(imageUrls:Array<String>, scrollView:UIScrollView) {
        var index = 0
        for screenShot in (detailModel?.screenshotUrls)! {
            let imageView = UIImageView()
            imageView.loadImageUsingCache(withUrl: screenShot)
            let positionX = (scrollView.frame.size.width / 2) * CGFloat(index)
            imageView.frame = CGRect(x:positionX,
                                     y: 0,
                                     width: scrollView.frame.size.width/2,
                                     height: scrollView.frame.size.height)
            scrollView.addSubview(imageView)
            index += 1
            scrollView.contentSize = CGSize(width:(scrollView.frame.size.width / 2) * CGFloat(index), height:0)
        }
    }

}
