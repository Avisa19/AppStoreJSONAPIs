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
//    var dismissHandler: (() -> ())?
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icons8-cancel"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .large {
            setupCloseButton()
            collectionView.contentInset = .init(top: 60, left: 0, bottom: 0, right: 0)
        } else {
            collectionView.isScrollEnabled = false
        }

        collectionView.backgroundColor = .white
        
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: multipleCell)
        
        // never execute fetch code inside of the view.
        //        Service.shared.fetchGames { (apps, err) in
        //            if let err = err {
        
    }
    
//    override var prefersStatusBarHidden: Bool { return true }
    
    fileprivate func setupCloseButton() {
         
         view.addSubview(closeButton)
         closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
     }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .small {
            return min(4, apps.count)
        }
        
        return apps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleCell, for: indexPath) as! MultipleAppCell
        cell.result = apps[indexPath.item]
        return cell
    }
    fileprivate let spacing: CGFloat = 16
    
    fileprivate let mode: Mode
    
    enum Mode {
        case small, large
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if mode == .small {
            let height = (view.frame.height - 3 * spacing) / 4
            return CGSize(width: view.frame.width, height: height)
        }
        return CGSize(width: view.frame.width - 48, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
   
}
