//
//  TodayController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 21/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    // define a data model, and give it value , instaed of json Data
    
    var items = [TodayItem]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
       let uiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        uiv.color = .darkGray
        uiv.startAnimating()
        return uiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489067197, alpha: 1)
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    fileprivate func fetchData() {
        // dispatchGroup
        let dispatchGroup = DispatchGroup()
        
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, err) in
            if let err = err {
                print("Failed to fetch topGrossing Apps:", err)
                return
            }
            
            topGrossingGroup = appGroup
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, err) in
            if let err = err {
                print("Failed to fetch games Apps:", err)
                return
            }
            
            gamesGroup = appGroup
            
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .main) {
            // I'll have access to grossing and games Apps somehow
            print("Finished fetching...")
            self.activityIndicatorView.stopAnimating()
            
            self.items = [
                
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden-1"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden-1"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
                
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden-1"), description: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed.results ?? [])
            ]
            
            self.collectionView.reloadData()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.multipleAppListController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapMultipleCell)))
        
        return cell
    }
    
    @objc func handleTapMultipleCell(gesture: UITapGestureRecognizer) {
        
        let tapCell = gesture.view
        
        var didTapView = tapCell?.superview
        
        // we iterate through parent view up to up while we reached to this paticular cell.
        while didTapView != nil {
            if let cell = didTapView as? TodayMultipleAppCell {
                
                // hit the right cell according to cell number.
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
                let fullController = TodayMultipleAppsController(mode: .fullScreen)
                
                fullController.apps = self.items[indexPath.item].apps
                present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
                
            }
            
            didTapView = didTapView?.superview
        }
        
    }
    
    var startingFrame: CGRect?
    var appsFullScreenController: AppsFullScreenController!
    
    static let cellSize: CGFloat = 500
    
    var anchoredConstraints: AnchoredConstraints?
    
    func setupTopConstraintForHeaderCell(constant: CGFloat) {
        guard let cell = self.appsFullScreenController.tableView.cellForRow(at: [0, 0]) as? FullScreenHeaderCell else { return }
        
        cell.todayCell.topConstraint?.constant = constant
        cell.layoutIfNeeded()
    }
}


extension TodayController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return .init(top: 32, left: 0, bottom: 32, right: 0)
       }
    
}


extension TodayController {
    
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullController = TodayMultipleAppsController(mode: .fullScreen)
        fullController.apps = self.items[indexPath.item].apps
        present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch items[indexPath.item].cellType {
        case .multiple:
            showDailyListFullScreen(indexPath)
        default:
            showSingleAppFullScreen(indexPath)
        }
    
        
    }
    
    fileprivate func setupSingleAppFullScreenController(_ indexPath: IndexPath) {
        let appsFullScreenController = AppsFullScreenController()
        appsFullScreenController.todayItem = items[indexPath.item]
        appsFullScreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        
        appsFullScreenController.view.layer.cornerRadius = 16
        self.appsFullScreenController = appsFullScreenController
    }
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // absolute coordinate of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
    }
    
    fileprivate func setupFullScreenStartingPostion(_ indexPath: IndexPath) {
        let fullScreenView = appsFullScreenController.view!
        
        view.addSubview(fullScreenView)
        
        // we want to remove VC everytime we finishing the addChild() ***Important***
        
        self.collectionView.isUserInteractionEnabled = false
        
        addChild(appsFullScreenController)
        
     
        setupStartingCellFrame(indexPath)
        
        //        blueView.frame = startingFrame
        
        guard let startingFrame = startingFrame else { return }
        
        self.anchoredConstraints = fullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        

        
        self.view.layoutIfNeeded()
        
    }
    
    fileprivate func beginAnimationAppFullScreen() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded() // Start Animating
            
            self.tabBarController?.tabBar.isHidden = true
            
            self.setupTopConstraintForHeaderCell(constant: 48)
            
        }, completion: nil)
    }
    
    fileprivate func showSingleAppFullScreen(_ indexPath: IndexPath) {
       
        // #1
        setupSingleAppFullScreenController(indexPath)
        
        // #2 setup fullscreen on its starting position
        setupFullScreenStartingPostion(indexPath)
        
        // 3# begin Animation of AppFullScreen
        beginAnimationAppFullScreen()
       
    }
    
    @objc func handleRemoveRedView() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appsFullScreenController.tableView.scrollToRow(at: [0, 0], at: .top, animated: true)
            
            guard let startingFrame = self.startingFrame else { return }
            
            
            self.anchoredConstraints?.top?.constant = startingFrame.origin.y
            self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
            self.anchoredConstraints?.width?.constant = startingFrame.width
            self.anchoredConstraints?.height?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.isHidden = false
            
            self.setupTopConstraintForHeaderCell(constant: 24)
            
        }, completion: { _ in
            
            self.appsFullScreenController.view?.removeFromSuperview()
            // addChild() then removing it here.
            self.appsFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
}
