//
//  TodayCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 21/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let imageview = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        addSubview(imageview)
        imageview.centerInSuperview(size: .init(width: 240, height: 240))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
