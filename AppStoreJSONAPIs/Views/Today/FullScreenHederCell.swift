//
//  FullScreenHederCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 21/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class FullScreenHeaderCell: UITableViewCell {
    
    let todayCell = TodayCell()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        todayCell.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
