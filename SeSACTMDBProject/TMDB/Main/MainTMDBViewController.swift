//
//  MainTMDBViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/11.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

import TMDBCustomFramework


class MainTMDBViewController: UIViewController {
    
    var movieData: [Movie] = []
    var currentPage = 1
    let totalPage = 1000
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("=============\(UserDefaults.standard.bool(forKey: "First"))")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        let nib = UINib(nibName: MainTMDBCollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MainTMDBCollectionViewCell.reuseIdentifier)
        
        collectionViewLayout()
        fetchMovieByAPIManager()
        print("===\(currentPage)")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(cinemaButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ticket.fill"), style: .plain, target: self, action: #selector(alertButtonClicked))
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        showAlert(title: "Framework의 Alert입니다", message: "Framework", buttonTitle: "확인") { _ in
//            self.view.backgroundColor = .lightGray
//        }
    }
    
    @objc func cinemaButtonClicked(_ sender: UIButton) {
        // 검색화면 UIVC
        let sb = UIStoryboard(name: "MapCinema", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapCinemaViewController") as! MapCinemaViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func alertButtonClicked (_ sender: UIButton) {
        let sb = UIStoryboard(name: "MainView", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchMovieByAPIManager() {
        APIManager.shared.fetchMovie(page: currentPage) { json in
            for movie in json["results"].arrayValue {
                
                let title = movie["title"].stringValue
                let release = movie["release_date"].stringValue
                let overview = movie["overview"].stringValue
                let backImage = EndPoint.imageURL + movie["backdrop_path"].stringValue
                let posterImage = EndPoint.imageURL + movie["poster_path"].stringValue
                let vote = movie["vote_average"].doubleValue
                let movieId = movie["id"].intValue
                let genreid = movie["genre_ids"][0].intValue
                
                let data = Movie(title: title, release: release, overview: overview, image: backImage, vote: vote, poster: posterImage, movieid: movieId, genreid: genreid)
                
                self.movieData.append(data)
                
                print(self.movieData)
            }
            self.collectionView.reloadData()
        }
    }
    
    func fetchVideoByAPIManager(id: Int) {
        APIManager.shared.fetchVideo(id: id) { json in
            let key = json["results"][0]["key"].stringValue
            self.transitionWithKeyValue(key: key)
            
        }
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
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let itemCount: CGFloat = 1
        
        let width = (UIScreen.main.bounds.width - spacing * (itemCount + 1)) / itemCount
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    
}

extension MainTMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    //MARK: 페이지네이션
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.item && movieData.count < totalPage {
                currentPage += 1
                fetchMovieByAPIManager()
            }
            print("===\(currentPage)")

            print("===\(indexPaths)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTMDBCollectionViewCell.reuseIdentifier, for: indexPath) as? MainTMDBCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configCell(data: movieData[indexPath.row])
        print("####", #function, movieData[indexPath.row])
        
        cell.linkButton.tag = indexPath.row
        cell.linkButton.addTarget(self, action: #selector(clickedLinkButton), for: .touchUpInside)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Header", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HeaderViewController") as? HeaderViewController else { return }
        
        vc.movieData = movieData[indexPath.row]
        print("####",#function, vc.movieData)
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
