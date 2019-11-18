//
//  AppDetailController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 18/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import SDWebImage

private let detailCellId = "DetailCell"
private let previewCellId = "previewCellId"

class AppDetailController : BaseListController {
    
    var appId: String? {
        didSet {
            
            guard let appId = appId else { return }
            let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (app: SearchResult?, err) in
                if let err = err {
                    print("Failed to fetch App's Detail:", err)
                    return
                }
                // Success
                let app = app?.results.first
                self.app = app
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var app: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppsDetailCell
            cell.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.horizentalController.app = self.app
            return cell
        }
    }
}


extension AppDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)
            let dummyCell = AppsDetailCell(frame: frame)
            dummyCell.app = self.app
            dummyCell.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 1000)
            let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
            
            return CGSize(width: view.frame.width, height: estimatedSize.height)
            
        } else {
            
            return CGSize(width: view.frame.width, height: 500)
        }
    }
    
    
}
