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
private let reviewCellId = "reviewCellId"

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
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppsDetailCell
            cell.app = self.app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.horizentalController.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewCell
            return cell
        }
    }
}


extension AppDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        
        if indexPath.item == 0 {
            
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)
            let dummyCell = AppsDetailCell(frame: frame)
            dummyCell.app = self.app
            dummyCell.layoutIfNeeded()
            
            let targetSize = CGSize(width: view.frame.width, height: 1000)
            let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
            
            height = estimatedSize.height
            
        } else if indexPath.item == 1 {
            
            height = 500
            
        } else {
            height = 280
        }
        
        return .init(width: view.frame.width, height: height)
    }
    
    
}
