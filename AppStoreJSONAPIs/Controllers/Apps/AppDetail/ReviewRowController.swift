//
//  ReviewRowController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 19/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

private let reviewAndRatingCellId = "ReviewAndRatingCell"

class ReviewRowController: HorizentalSnappingController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ReviewAndRatingCell.self, forCellWithReuseIdentifier: reviewAndRatingCellId)
     
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
     
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewAndRatingCellId, for: indexPath) as! ReviewAndRatingCell
        
        return cell
    }
    
}

extension ReviewRowController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
