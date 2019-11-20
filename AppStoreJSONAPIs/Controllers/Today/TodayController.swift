//
//  TodayController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 20/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

private let todayCellId = "todayCellId"

class TodayController: BaseListController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489067197, alpha: 1)
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: todayCellId)
       
        collectionView.contentInset = .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCellId, for: indexPath) as! TodayCell
        return cell
    }
    
    var startingFrame: CGRect?
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 48, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}

extension TodayController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pinkView = UIView()
        pinkView.backgroundColor = .systemPink
        pinkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemovePinkView)))
        view.addSubview(pinkView)
        
        pinkView.layer.cornerRadius = 16
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        // absolute coordinates of cell
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        pinkView.frame = startingFrame
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            pinkView.frame = self.view.frame
            
        }, completion: nil)
        
    }
    
    @objc fileprivate func handleRemovePinkView(gesture: UITapGestureRecognizer) {
        
        // access starting frame
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            gesture.view?.frame = self.startingFrame ?? .zero
            
        }, completion: { _ in
            
            gesture.view?.removeFromSuperview()
        })
    }
}
