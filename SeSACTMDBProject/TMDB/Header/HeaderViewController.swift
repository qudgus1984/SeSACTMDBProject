//
//  HeaderViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
import SwiftUI

class HeaderViewController: UIViewController {
    
    var castDataList: [HeaderCast] = []
    static var structHeaderList: [HeaderList] = []
    var structHeaderList2: [HeaderList] = []

    
    @IBOutlet weak var HeaderTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var overViewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "출연/제작"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(cancelButton))
        
        HeaderTableView.dataSource = self
        HeaderTableView.delegate = self
        
        HeaderTableView.register(UINib(nibName: HeaderCellTableViewCell.HeaderIdentifier, bundle: nil), forCellReuseIdentifier: HeaderCellTableViewCell.HeaderIdentifier)
                
        HeaderTableView.rowHeight = 150
        
        fetchImage()
        headerDetail()
    }
    
    @objc func cancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchImage() {
        let url = EndPoint.TMDBURL + "api_key=\(APIKey.TMDBKey)&page=\(UserDefaults.standard.integer(forKey: "pageNum"))"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for Header in json["results"].arrayValue {
                    
                    let posterImageURL = URL(string: EndPoint.imageURL + Header["poster_path"].stringValue)
                    self.posterImageView.kf.setImage(with: posterImageURL)
                    let backgroundImageURL = URL(string: EndPoint.imageURL + Header["backdrop_path"].stringValue)
                    self.backgroundImageView.kf.setImage(with: backgroundImageURL)
                    self.titleLabel.text = Header["title"].stringValue
                    self.overViewTextView.text = Header["overview"].stringValue

                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    
    func headerDetail() {
        let url = "https://api.themoviedb.org/3/movie/\(TMDBViewController.movieIDChoice[UserDefaults.standard.integer(forKey: "pageNum")-1])/credits?api_key=\(APIKey.TMDBKey)&language=en-US"
        AF.request(url, method: .get ).validate(statusCode: 200...500).responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for item in json["crew"].arrayValue{
                    let data = HeaderCast(name: item["original_name"].stringValue, characterName: item["name"].stringValue, profilePath: item["profile_path"].stringValue)
                    
                    castDataList.append(data)
                }
                HeaderTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

extension HeaderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = HeaderTableView.dequeueReusableCell(withIdentifier: HeaderCellTableViewCell.HeaderIdentifier, for: indexPath) as? HeaderCellTableViewCell else { return HeaderCellTableViewCell() }
        item.nameLabel.text = castDataList[indexPath.row].name
        item.charactorLabel.text = castDataList[indexPath.row].characterName
        
        let imageURL = URL(string: EndPoint.imageURL+castDataList[indexPath.row].profilePath)
        item.profileImageView.contentMode = .scaleAspectFit
        item.profileImageView.kf.setImage(with: imageURL)
        
        return item
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
