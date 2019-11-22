//
//  TodayItem.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 21/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

struct TodayItem {
    
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    //enum
    let cellType: CellType
    
    enum CellType: String {
        case single, multiple
    }
    
    let apps: [FeedResult]
}

// with data Model you can be flexible, you can give data by default, or json Data
