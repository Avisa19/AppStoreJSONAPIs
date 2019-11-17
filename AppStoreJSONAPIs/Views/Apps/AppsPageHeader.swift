//
//  AppsPageHeader.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 16/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    let appsHeaderHorizentalController = AppsHeaderHorizentalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appsHeaderHorizentalController.view.backgroundColor = .systemOrange
        addSubview(appsHeaderHorizentalController.view)
        appsHeaderHorizentalController.view.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
