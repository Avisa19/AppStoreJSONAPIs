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
    
    fileprivate func fetchiTunesApps() {
        
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, respo, err) in
            if let err = err {
                print("Failed to fetch data from internet:", err)
                return
            }
            
            // success
            guard let data = data else { return }
            do {
                
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//                print(searchResult)
                searchResult.results.forEach({print($0.trackName)})
            
                
            } catch let jsonErr {
                print("Failed to fetch json Url:", jsonErr)
            }
            
        }.resume() // fires off the request
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchIdentifier, for: indexPath) as! SearchAppCell
    
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
