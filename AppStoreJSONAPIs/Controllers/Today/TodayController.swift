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
    
   
    var appFullScreenController: AppFullScreenController?
     var startingFrame: CGRect?
    
    // prevent from bug
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
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
        
        let appFullscreenController = AppFullScreenController()
        
        guard let appFullScreenView = appFullscreenController.view else { return }
        appFullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAppFullscreenDismissal)))
        
        view.addSubview(appFullScreenView)
        
        addChild(appFullscreenController)
        
        self.appFullScreenController = appFullscreenController
        
        appFullScreenView.layer.cornerRadius = 16
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        // absolute coordinates of cell
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        // 1.start move
        // frames are not reliable for animation
        // auto layout constarint animation
        topConstraint = appFullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = appFullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = appFullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = appFullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            // 2.second move
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded() //start Animating
            
           self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
        }, completion: nil)
        
    }
    
    @objc fileprivate func handleAppFullscreenDismissal(gesture: UITapGestureRecognizer) {
        
        // access starting frame
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullScreenController?.tableView.contentOffset = .zero
            
            guard let startingFrame = self.startingFrame else { return }
            // 3.and with tap ... last move
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded() // start Animating
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
        }, completion: { _ in
            
            // 4. remove completely
            self.appFullScreenController?.view.removeFromSuperview()
            self.appFullScreenController?.removeFromParent()
        })
    }
}
