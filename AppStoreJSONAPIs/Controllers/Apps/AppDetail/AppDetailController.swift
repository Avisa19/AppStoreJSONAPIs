//
//  AppDetailController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 18/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

private let detailCellId = "DetailCell"

class AppDetailController : BaseListController {
    
    var appId: String? {
        didSet {
            
            guard let appId = appId else { return }
            let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
                if let err = err {
                    print("Failed to fetch App's Detail:", err)
                    return
                }
                // Success
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppsDetailCell
        return cell
    }
}


extension AppDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    
}
