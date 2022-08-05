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
    
    var list: [TMDBList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDBCollectionView.register(UINib(nibName: TMDBCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TMDBCollectionViewCell.identifier)

        TMDBCollectionView.delegate = self
        TMDBCollectionView.dataSource = self

        CellLayout()
        
        fetchTMDB()
    }
    
    func CellLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 2)
        
        layout.itemSize = CGSize(width: width / 1.1, height: (width / 1.1) * 1.5 )
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        TMDBCollectionView.collectionViewLayout = layout
    }
    
    func fetchTMDB() {
        let url = EndPoint.TMDBURL + "api_key=\(APIKey.TMDBKey)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                for TMDB in json["results"].arrayValue {
                    
                    let imageUrl = EndPoint.imageURL + TMDB["poster_path"].stringValue
                    let releaseDate = TMDB["first_air_date"].stringValue
                    let rate = TMDB["vote_average"].doubleValue
                    let title = TMDB["name"].stringValue
                    let overview = TMDB["overview"].stringValue
                    let genre = TMDB["genre_ids"][0].intValue
                    
                    let data = TMDBList(releaseDate: releaseDate, genre: genre, posterImage: imageUrl, rate: rate, title: title, overview: overview)

                    
                        self.list.append(data)
                    }

                self.TMDBCollectionView.reloadData()
                
                print(self.list)
                
            case .failure(let error):
                print(error)
            }
        
        }
    }
}
extension TMDBViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = TMDBCollectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.identifier, for: indexPath) as? TMDBCollectionViewCell else { return TMDBCollectionViewCell() }
        
        item.setData(indexPath: indexPath, list: list)
        return item
    }
}
