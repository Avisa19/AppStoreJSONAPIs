//
//  AppsSearchController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

private let searchIdentifier = "Cell"

class AppsSearchController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        self.collectionView!.register(SearchAppCell.self, forCellWithReuseIdentifier: searchIdentifier)
        
        fetchiTunesApps()
    }
    
    fileprivate var appsResult = [Result]()
    
    fileprivate func fetchiTunesApps() {
        
        Service.shared.fetchApps { (results, err) in
            if let err = err {
                print("Failed to fetch jsonData:", err)
                return
            }
            
            self.appsResult = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appsResult.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchIdentifier, for: indexPath) as! SearchAppCell
        
        let appResult = appsResult[indexPath.item]
        
        cell.nameLabel.text = appResult.trackName
        
        cell.categoryLabel.text = appResult.primaryGenreName
        
        cell.ratingLabel.text = "Rating: " +  "\(appResult.averageUserRating)"
    
        return cell
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
}
