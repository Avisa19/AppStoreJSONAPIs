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
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icons8-cancel"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .fullScreen {
            setupCloseButton()
            navigationController?.isNavigationBarHidden = true
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
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullScreen {
            return apps.count
        }
        
        return min(4, apps.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         if mode == .fullScreen {
             return .init(top: 60, left: 24, bottom: 12, right: 24)
         }
         return .zero
     }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleCell, for: indexPath) as! MultipleAppCell
        cell.result = apps[indexPath.item]
        return cell
    }
    
    fileprivate let spacing: CGFloat = 16
    
    fileprivate let mode: Mode
    
    enum Mode {
        case small, fullScreen
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
         
         let height: CGFloat = 68
        
         if mode == .fullScreen {
             return .init(width: view.frame.width - 48, height: height)
         }
         
         return .init(width: view.frame.width, height: height)
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
}

extension TodayMultipleAppsController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appId = self.apps[indexPath.item].id
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
        
    }
}
