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
        let uiv = UIActivityIndicatorView(style: .whiteLarge)
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
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden-1"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
                
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden-1"), description: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed.results ?? []),
                
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden-1"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
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
        
        
        return cell
    }
    
    var startingFrame: CGRect?
    var appsFullScreenController: AppsFullScreenController!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    static let cellSize: CGFloat = 500
    
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if items[indexPath.item].cellType == .multiple {
            let fullController = TodayMultipleAppsController(mode: .large)
            fullController.apps = self.items[indexPath.item].apps
            present(fullController, animated: true)
            return
        }
        
        let appsFullScreenController = AppsFullScreenController()
        appsFullScreenController.todayItem = items[indexPath.item]
        appsFullScreenController.dismissHandler = {
                   self.handleRemoveRedView()
               }
        
        let fullScreenView = appsFullScreenController.view!
        
        view.addSubview(fullScreenView)
        
        fullScreenView.layer.cornerRadius = 16
        
        // we want to remove VC everytime we finishing the addChild() ***Important***
        self.appsFullScreenController = appsFullScreenController
        
        self.collectionView.isUserInteractionEnabled = false
        
        addChild(appsFullScreenController)
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // absolute coordinate of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
//        blueView.frame = startingFrame
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        self.topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        self.leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        self.widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        self.heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        
            self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
//            blueView.frame = self.view.frame
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded() // Start Animating

            self.tabBarController?.tabBar.isHidden = true
            
            self.setupTopConstraintForHeaderCell(constant: 48)
            
        }, completion: nil)
    }
    
    @objc func handleRemoveRedView() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appsFullScreenController.tableView.scrollToRow(at: [0, 0], at: .top, animated: true)
            
            guard let startingFrame = self.startingFrame else { return }
            
//            gesture.view?.frame = startingFrame
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
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
