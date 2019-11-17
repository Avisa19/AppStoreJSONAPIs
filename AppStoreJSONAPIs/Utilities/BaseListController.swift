//
//  BaseListController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit


class BaseListController: UICollectionViewController {
    
    init() {
         super.init(collectionViewLayout: UICollectionViewFlowLayout())
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

}
