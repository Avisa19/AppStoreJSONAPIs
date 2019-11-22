//
//  TodayMultipleAppsController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 22/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

private let multipleCell = "multipleCell"

class TodayMultipleAppsController: BaseListController {
    
    var apps = [FeedResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: multipleCell)
        // never execute fetch code inside of the view.
//        Service.shared.fetchGames { (apps, err) in
//            if let err = err {
//                print("Failed to fetch games App for today list:", err)
//                return
//            }
//            guard let apps = apps?.feed.results else { return }
//            self.apps = apps
//            
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, apps.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleCell, for: indexPath) as! MultipleAppCell
        cell.result = apps[indexPath.item]
        return cell
    }
    fileprivate let spacing: CGFloat = 16
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.height - 3 * spacing) / 4
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
