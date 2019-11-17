//
//  AppsHeaderHorizentalController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 16/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

private let appsHeaderIdentifier = "Cell"

class AppsHeaderHorizentalController: BaseListController {
    
    var socialApps = [FeedResult]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        self.collectionView!.register(AppsHeaderCell.self, forCellWithReuseIdentifier: appsHeaderIdentifier)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsHeaderIdentifier, for: indexPath) as! AppsHeaderCell
        
        cell.feedResult = socialApps[indexPath.item]
        
        return cell
    }


}

extension AppsHeaderHorizentalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 0)
    }
}
