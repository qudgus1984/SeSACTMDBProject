//
//  MainViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/09.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON
class MainViewController: UIViewController {
    

    @IBOutlet weak var mainTableView: UITableView!
    
    
    let numberList: [[Int]] = [
        [Int](1...10),
        [Int](11...20),
        [Int](21...30),
        [Int](31...40),
        [Int](41...50),
        [Int](51...60),
        [Int](61...70),
        [Int](71...80)
    ]
    
    var similarList: [[String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        CardAPIManager.shared.requestImage { value in
            dump(value)
            
            self.similarList = value
            self.mainTableView.reloadData()
        }
        
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return similarList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell()}
        cell.backgroundColor = .black
        cell.titleLabel.text = "\(CardAPIManager.shared.movieList[indexPath.section].0)와 비슷한 컨텐츠"
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.tag = indexPath.section
        cell.contentCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        cell.contentCollectionView.reloadData()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: "\(CardAPIManager.shared.imageURL)\(similarList[collectionView.tag][indexPath.item])")
        cell.imageCardView.cardImageView.kf.setImage(with: url)
        return cell

    }
    
    
}
