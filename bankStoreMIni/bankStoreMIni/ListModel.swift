//
//  ListModel.swift
//  bankStoreMIni
//
//  Created by 최 봉식 on 2018. 6. 27..
//  Copyright © 2018년 jake. All rights reserved.
//

import UIKit

class ListModel: NSObject {
    var name : String?
    var image : String?
    var id : Int?
    
    init(name:String?, image:String?, id:Int?){
        self.name = name
        self.image = image
        self.id = id
    }
}
