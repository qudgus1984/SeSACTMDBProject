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
    
    var movieData: [Movie] = []
    var page = 1
    var totalCount = 0
    
    var movieLink: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDBCollectionView.prefetchDataSource = self
        TMDBCollectionView.delegate = self
        TMDBCollectionView.dataSource = self
        
        TMDBCollectionView.register(UINib(nibName: TMDBCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TMDBCollectionViewCell.identifier)
        
        CellLayout()
        
    }
    func fetchMovieByAPIManager(page: Int) {
        APIManager.shared.fetchMovie(page: page) { json in
            
            for movie in json["results"].arrayValue {
                
                let title = movie["title"].stringValue
                let release = movie["release_date"].stringValue
                let overview = movie["overview"].stringValue
                let backImage = EndPoint.imageURL + movie["backdrop_path"].stringValue
                let posterImage = EndPoint.imageURL + movie["poster_path"].stringValue
                let vote = movie["vote_average"].doubleValue
                let movieId = movie["id"].intValue
                let genreid = movie["genre_ids"][0].intValue
                
                print("현재 페이지 \(self.page)")
                print("영화 제목 \(title)")
                
                let data = Movie(title: title, release: release, overview: overview, image: backImage, vote: vote, poster: posterImage, movieid: movieId, genreid: genreid)
                
                self.movieData.append(data)
                // self.MainCollectionView.reloadData()
                
                print("json 타이틀: \(title)")
                print("data 타이틀: \(data.title)")
                print("movieID: \(movieId)")
                print("genreID: \(genreid)")
                
                print("data 갯수: \(self.movieData.count)")
                print("================")
                
            }
        }
    }
    
    func fetchVideoByAPIManager(id: Int) {
        APIManager.shared.fetchVideo(id: id) { json in
            let key = json["results"][0]["key"].stringValue
            self.transitionWithKeyValue(key: key)
        }
    }
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let itemCount: CGFloat = 1
        
        let width = (UIScreen.main.bounds.width - spacing * (itemCount + 1)) / itemCount
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        TMDBCollectionView.collectionViewLayout = layout
    }
    
    func transitionWithKeyValue(key: String) {
        let sb = UIStoryboard(name: "Web", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
        
        vc.key = key
        
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true)
    }
    
    @objc func clickedLinkButton(sender: UIButton) {
        let id = movieData[sender.tag].movieid
        
        fetchVideoByAPIManager(id: id)
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
}


extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.item && movieData.count < totalCount {
                page += 1
                
                fetchMovieByAPIManager(page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = TMDBCollectionView.dequeueReusableCell(withReuseIdentifier: "TMDBCollectionViewCell", for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configCell(data: movieData[indexPath.row])
        
        cell.linkButton.tag = indexPath.row
        cell.linkButton.addTarget(self, action: #selector(clickedLinkButton), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Header", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HeaderViewController") as? HeaderViewController else { return }
        
        vc.movieData = movieData[indexPath.row]
        
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
