//
//  MusicController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 25/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import SDWebImage

// 1. Implement cell
// 2. Implement a footer for the leader view.

private let musicCell = "MusicCell"
private let footerCell = "FooterCell"

class MusicController: BaseListController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCell)
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: musicCell)
        
        fetchData()
    }
    
    var results = [Result]()
    fileprivate let searchTerm = "Taylor"
    
    fileprivate func fetchData() {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=40&limit=20"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
            if let err = err {
                print("Failed to fetch Music List:", err)
                return
            }
            
            // We must do the print
//            print(searchResult?.results ?? [])
            
            self.results = searchResult?.results ?? []
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCell, for: indexPath) as! MusicLoadingFooter
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    var isPaginating = false
    var isDonePaginating = false
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: musicCell, for: indexPath) as! TrackCell
        
        cell.result = results[indexPath.item]
        
        // initiate pagination
        if indexPath.item == results.count - 1 && !isPaginating {
            
            isPaginating = true
            print("Start fecthing...")
            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
                if let err = err {
                    print("Failed to fetch Music List:", err)
                            return
                        }
                        
                        // We must do the print
                
                if searchResult?.results.count == 0 {
                    self.isDonePaginating = true
                }
                
                sleep(2)
                
                self.results += searchResult?.results ?? []
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                self.isPaginating = false
            }
            
        }
        
        return cell
    }
}

extension MusicController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
