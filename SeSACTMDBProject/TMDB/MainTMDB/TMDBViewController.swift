//
//  TMDBViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/04.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class TMDBViewController: UIViewController {
        
    @IBOutlet weak var TMDBCollectionView: UICollectionView!
    
    static var listStruct: [TMDBList] = []
    var listStruct2 : [TMDBList] = []
    var page = 1
    var totalCount = 0
    static var movieIDChoice : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDBCollectionView.register(UINib(nibName: TMDBCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TMDBCollectionViewCell.identifier)
        
        TMDBCollectionView.prefetchDataSource = self
        TMDBCollectionView.delegate = self
        TMDBCollectionView.dataSource = self
        fetchImage()
        CellLayout()
    }
    
    func CellLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 2)
        
        layout.itemSize = CGSize(width: width / 1.1, height: (width / 1.1) * 1.8 )
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        TMDBCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Header", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HeaderViewController") as! HeaderViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchImage() {
        ImageTMDBAPIManager.shared.fetchTMDB(page: page) { totalCount, list in
            self.totalCount = totalCount
            self.listStruct2 = list
            
            self.TMDBCollectionView.reloadData()
        }
    }
    
    }

extension TMDBViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TMDBViewController.listStruct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = TMDBCollectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.identifier, for: indexPath) as? TMDBCollectionViewCell else { return TMDBCollectionViewCell() }
        
        item.setData(indexPath: indexPath, list: TMDBViewController.listStruct)
        return item
    }
}

extension TMDBViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            print(page)
            print(TMDBViewController.listStruct.count)
            print(totalCount)
            UserDefaults.standard.set(indexPath[1], forKey: "pageNum")
            print(UserDefaults.standard.integer(forKey: "pageNum"))

            if (TMDBViewController.listStruct.count - 1 == indexPath.item)  && (TMDBViewController.listStruct.count < totalCount) {
                page += 20
                fetchImage()

            }
//            UserDefaults.standard.set(indexPaths[1], forKey: "page")
//            print(UserDefaults.standard.integer(forKey: "page"))
        }
}
}
