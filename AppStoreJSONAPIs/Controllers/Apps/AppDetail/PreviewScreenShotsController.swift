//
//  PreviewScreenShotsController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 18/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import SDWebImage

private let screenshotId = "ScreenshotId"

class PreviewScreenShotsController: HorizentalSnappingController {
    
    var app: Result? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(PreviewScreenshotsCell.self, forCellWithReuseIdentifier: screenshotId)
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotId, for: indexPath) as! PreviewScreenshotsCell
        
        if let screenshots = self.app?.screenshotUrls?[indexPath.item] {
            cell.imageView.sd_setImage(with: URL(string: screenshots), completed: nil)
        }
        
        return cell
        
    }
}

extension PreviewScreenShotsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 250, height: view.frame.height)
        
    }
}
