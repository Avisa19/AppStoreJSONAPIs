//
//  AppsController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

private let appsIdentifier = "Cell"
private let headerIdentifier = "HeaderCell"

class AppsPageController: BaseListController {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let uiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        uiv.color = .black
        uiv.startAnimating()
        uiv.hidesWhenStopped = true
        return uiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        self.collectionView!.register(AppsGroupCell.self, forCellWithReuseIdentifier: appsIdentifier)
        
        self.collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    var groups = [AppGroup]()
    
    var socialApps = [FeedResult]()
    
    fileprivate func fetchData() {
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        
        // It helps you fetch data together
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch game data:", err)
                return
            }
            group1 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch game data:", err)
                return
            }
            group2 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFree { (appGroup, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch game data:", err)
                return
            }
            
            group3 = appGroup
        }

        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (appGroup, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Failed to fetch game data:", err)
                return
            }
            
            //            appGroup?.feed.results.forEach({print($0.name)})
            
            
            self.socialApps = appGroup?.feed.results ?? []
            
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Completed your dispatch group tasks...")
            self.activityIndicatorView.stopAnimating()
            
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
           
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! AppsPageHeader
       
        header.appsHeaderHorizentalController.socialApps = self.socialApps
        header.appsHeaderHorizentalController.collectionView.reloadData()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsIdentifier, for: indexPath) as! AppsGroupCell
    
        let appsGroup = groups[indexPath.item]
        
        cell.titleLabel.text = appsGroup.feed.title
        cell.horizentalController.appGroup = appsGroup
        cell.horizentalController.collectionView.reloadData()
        cell.horizentalController.didSelectHandler = { [weak self] feedResult in
            
            let appDetailController = AppDetailController()
            appDetailController.navigationItem.title = feedResult.name
            appDetailController.appId = feedResult.id
            self?.navigationController?.pushViewController(appDetailController, animated: true)
        }
        
        return cell
    }

}

extension AppsPageController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}


