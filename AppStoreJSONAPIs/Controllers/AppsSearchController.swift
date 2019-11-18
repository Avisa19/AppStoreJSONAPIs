//
//  AppsSearchController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import SDWebImage

private let searchIdentifier = "Cell"

class AppsSearchController: BaseListController {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    var timer: Timer?
    
    let enterSearchTermLabel: UILabel = {
       let label = UILabel()
        label.text = "Please enter search term above..."
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        self.collectionView!.register(SearchAppCell.self, forCellWithReuseIdentifier: searchIdentifier)
  
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 250, left: 0, bottom: 0, right: 0))
        enterSearchTermLabel.centerXInSuperview()
        
        setupSearchBar()
    }
    
    fileprivate var appsResult = [Result]()

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appsResult.count != 0
        return appsResult.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchIdentifier, for: indexPath) as! SearchAppCell
        
        cell.appResult = appsResult[indexPath.item]
        
        return cell
    }
  
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
}

extension AppsSearchController: UISearchBarDelegate {
    
    fileprivate func setupSearchBar() {
        
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // introducing some delay before performing the search
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            // this actually fire my search
            Service.shared.fetchApps(searchTerm: searchText) { (searchResult, err) in
                      if let err = err {
                          print("Failed to fetch search:", err)
                          return
                      }
                      
                self.appsResult = searchResult?.results ?? []
                      DispatchQueue.main.async {
                          self.collectionView.reloadData()
                      }
                  }
            
        })
      
    }
}
